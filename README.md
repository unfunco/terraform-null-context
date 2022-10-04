# Terraform context module

![CI](https://github.com/unfunco/terraform-null-context/actions/workflows/ci.yaml/badge.svg)
[![License: Apache 2.0](https://img.shields.io/badge/License-Apache_2.0-purple.svg)](https://opensource.org/licenses/Apache-2.0)

Terraform module for generating consistent naming and tagging conventions.
This is not tied to any specific provider but has generally been used with
Amazon Web Services to generate billing tags and unique resource names.

## Getting started

### Requirements

* [Go] 1.19+ for unit-testing
* [Terraform] 1.3+

### Installation and usage

```terraform
module "context" {
  source  = "registry.terraform.io/unfunco/context/null"
  version = "0.2.0"

  organisation = var.context.organisation
  application  = var.context.application
  account      = var.context.account
  environment  = var.context.environment
  stack        = var.context.stack
}

variable "context" {
  description = "Single object for setting the entire context."

  type = object({
    organisation = optional(string)
    application  = string
    account      = string
    environment  = optional(string)
    stack        = string
  })
}
```

```terraform
resource "aws_s3_bucket" "assets" {
  bucket = module.context.id
  tags   = module.context.tags
}

resource "aws_ssm_parameter" "service_api_token" {
  name  = join("/", [module.context.path, "SERVICE-API-TOKEN"])
  tags  = module.context.tags
  type  = "SecureString"
  value = "CorrectHorseBatteryStaple"
}
```

```bash
TF_WORKSPACE=hyperglug_live_assets terraform apply -lock="true" -lock-timeout="1m" \
-var='context={"organisation":"honestempire","application":"hyperglug","account":"live","environment":"live","stack":"assets"}' \
-var-file="stack.tfvars.json"
```

```terraform
website_bucket_id = "hyperglug-live-assets"

website_bucket_tags = tomap({
  "Account"      = "live"
  "Application"  = "hyperglug"
  "Organisation" = "honestempire"
  "Stack"        = "assets"
  "Environment"  = "live"
})
```

#### Variables

| Name           | Default | Description                              |
|----------------|:-------:|------------------------------------------|
| `organisation` | `null`  | The name of the organisation.            |
| `application`  | `null`  | The name of the application.             |
| `account`      | `null`  | The name of the account.                 |
| `environment`  | `null`  | The name of the environment.             |
| `stack`        | `null`  | The name of the stack.                   |

#### Outputs

The outputs have been separated into two tables, the first table contains the
outputs that are most likely to be provided as inputs to other resources. The ID
output is a hyphenated concatenation of the application, account, environment
and stack inputs, and can be used for resource names, the path is
slash-delimited, and can be used for SSM parameter prefixes, for example.

| Name           | Description                                                 |
|----------------|-------------------------------------------------------------|
| `id`           | The disambiguated ID of the module.                         |
| `path`         | The disambiguated ID delimited with slashes.                |

The next table contains the outputs that are really just normalised versions of
the input variables.

| Name           | Description                                                     |
|----------------|-----------------------------------------------------------------|
| `organisation` | The normalised name of the organisation.                        |
| `application`  | The normalised name of the application.                         |
| `account`      | The normalised name of the account.                             |
| `environment`  | The normalised name of the environment.                         |
| `stack`        | The normalised name of the stack.                               |
| `tags`         | The normalised map of tags.                                     |

## License

© 2021 [Daniel Morris]  
Made available under the terms of the [Apache License 2.0](LICENSE.md).

[Daniel Morris]: https://unfun.co
[Go]: https://go.dev
[Honest Empire Ltd]: https://www.honestempire.com
[Terraform]: https://www.terraform.io
