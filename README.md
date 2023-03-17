# Terraform context module

![CI](https://github.com/unfunco/terraform-null-context/actions/workflows/ci.yaml/badge.svg)
[![License: Apache 2.0](https://img.shields.io/badge/License-Apache_2.0-purple.svg)](https://opensource.org/licenses/Apache-2.0)

Terraform module for generating consistent names and tags.

This module is not tied to any specific cloud provider but has generally been
used with Amazon Web Services to generate unique names and billing tags for
infrastructure resources.

## Getting started

### Requirements

- [Go] 1.20+ for unit-testing
- [Terraform] 1.3+

### Installation and usage

Add the following Terraform to your stack:

```terraform
module "context" {
  source  = "registry.terraform.io/unfunco/context/null"
  version = "0.3.0"

  organization = var.context.organization
  application  = var.context.application
  account      = var.context.account
  environment  = var.context.environment
  stack        = var.context.stack
}

variable "context" {
  description = "Single object for setting the entire context."

  type = object({
    organization = optional(string)
    application  = string
    account      = string
    environment  = optional(string)
    stack        = string
  })
}
```

When using [Terragrunt], you can use a `generate` block to create the context.

```terraform
generate "context" {
  contents = <<EOF
module "context" { ... }
variable "context" { ... }
EOF

  if_exists = "overwrite"
  path      = "context.tf"
}
```

The outputs from the context module can be used to uniquely name and tag your
infrastructure resources.

```terraform
resource "aws_s3_bucket" "assets" {
  bucket = module.context.id
  tags   = merge(module.context.tags, var.tags)
}

resource "aws_ssm_parameter" "api_token" {
  name  = join("/", [module.context.path, "API-TOKEN"])
  tags  = merge(module.context.tags, var.tags)
  type  = "SecureString"
  value = "CorrectHorseBatteryStaple"
}
```

Automate the composition of CLI commands and pass in the context as JSON,
an `apply` command might look something like this:

```bash
TF_WORKSPACE=hyperglug_live_assets terraform apply \
  -lock="true" \
  -lock-timeout="1m" \
  -var='context={"organization":"honestempire","application":"hyperglug","account":"live","environment":"live","stack":"assets"}' \
  -var-file="assets.tfvars.json"
```

With the examples above, the following names and tags are generated:

```terraform
bucket_id = "hyperglug-live-assets"

bucket_tags = tomap({
  "Account"      = "live"
  "Application"  = "hyperglug"
  "Organization" = "honestempire"
  "Stack"        = "assets"
  "Environment"  = "live"
})

ssm_parameter_name = "/hyperglug/live/assets/API-TOKEN"
```

<!-- BEGIN_TF_DOCS -->

#### Inputs

| Name         | Description                   | Type     | Default | Required |
| ------------ | ----------------------------- | -------- | ------- | :------: |
| account      | The name of the account.      | `string` | n/a     |   yes    |
| application  | The name of the application.  | `string` | n/a     |   yes    |
| environment  | The name of the environment.  | `string` | n/a     |   yes    |
| organization | The name of the organization. | `string` | n/a     |   yes    |
| stack        | The name of the stack.        | `string` | n/a     |   yes    |

<!-- END_TF_DOCS -->

#### Variables

| Name           |                       Default                        | Description                                 |
| -------------- | :--------------------------------------------------: | ------------------------------------------- |
| `organization` |                        `null`                        | The name of the organization.               |
| `application`  |                        `null`                        | The name of the application.                |
| `account`      |                        `null`                        | The name of the account.                    |
| `environment`  |                        `null`                        | The name of the environment.                |
| `order`        | `["application", "account", "environment", "stack"]` | Labels in the order they should be applied. |
| `stack`        |                        `null`                        | The name of the stack.                      |

#### Outputs

The outputs have been separated into two tables, the first table contains the
outputs that are most likely to be provided as inputs to other resources. The ID
output is a hyphenated concatenation of the application, account, environment
and stack inputs, and can be used for resource names, the path is
slash-delimited, and can be used for SSM parameter prefixes, for example.

| Name   | Description                                  |
| ------ | -------------------------------------------- |
| `id`   | The disambiguated ID of the module.          |
| `path` | The disambiguated ID delimited with slashes. |
| `tags` | The normalised map of tags.                  |

The next table contains the outputs that are really just normalised versions of
the input variables.

| Name           | Description                              |
| -------------- | ---------------------------------------- |
| `organization` | The normalised name of the organization. |
| `application`  | The normalised name of the application.  |
| `account`      | The normalised name of the account.      |
| `environment`  | The normalised name of the environment.  |
| `stack`        | The normalised name of the stack.        |

## License

© 2021 [Daniel Morris]\
Made available under the terms of the [Apache License 2.0](LICENSE.md).

[daniel morris]: https://unfun.co
[go]: https://go.dev
[honest empire ltd]: https://www.honestempire.com
[terraform]: https://www.terraform.io
[terragrunt]: https://terragrunt.gruntwork.io
