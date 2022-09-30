# Terraform context module

![CI](https://github.com/unfunco/terraform-null-context/actions/workflows/ci.yaml/badge.svg)
[![License: Apache 2.0](https://img.shields.io/badge/License-Apache_2.0-purple.svg)](https://opensource.org/licenses/Apache-2.0)

Terraform module for generating consistent naming and tagging conventions.

## Getting started

### Requirements

* [Go] 1.19+ for unit-testing
* [Terraform] 1.3+

### Installation and usage

The following documentation demonstrates the recommended way to use this module.

```terraform
module "context" {
  // source = "registry.terraform.io/unfunco/null/context"
  // version = "0.2.0"
  source = "git::git@github.com:unfunco/terraform-null-context.git?ref=main"

  organisation = var.organisation
  application  = var.application
  account      = var.account
  environment  = var.environment
  stack        = var.stack
  tags         = var.tags
}
```

```json
{
  "organisation": "Honest Empire",
  "application": "Hyperglug",
  "account": "live",
  "environment": "live",
  "stack": "website-v1"
}
```

```terraform
resource "aws_s3_bucket" "website_v1" {
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

```terraform
website_bucket_id = "hyperglug-live-website-v1"

website_bucket_tags = tomap({
  "Account"      = "live"
  "Application"  = "hyperglug"
  "Organisation" = "honestempire"
  "Stack"        = "website-v1"
  "Environment"  = "live"
})
```

```typescript
const context = JSON.stringify({
  organisation,
  application,
  account,
  environment,
  stack,
})

await $`terraform apply -var 'context=${context}'`
```

#### Variables

| Name           | Default | Description                              |
|----------------|:-------:|------------------------------------------|
| `organisation` | `null`  | The name of the organisation.            |
| `application`  | `null`  | The name of the application.             |
| `account`      | `null`  | The name of the account.                 |
| `environment`  | `null`  | The name of the environment.             |
| `stack`        | `null`  | The name of the stack.                   |
| `tags`         |  `{}`   | A map of tags to apply to all resources. |

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
