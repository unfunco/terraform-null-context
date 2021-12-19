# Terraform context module

Terraform module for enforcing consistent naming and tagging conventions. This
module is not tied to any specific Cloud provider but the output it produces and
the conventions it applies are currently targeted towards AWS resources.

## Getting started

### Requirements

* [Terraform] 1.0+

### Installation and usage

```terraform
provider "aws" {
  region = var.aws_region
}

module "context" {
  source = "git::git@github.com:honestempire/terraform-null-context.git?ref=main"

  enabled      = var.enabled
  organisation = var.organisation
  application  = var.application
  account      = var.account
  stage        = var.stage
  stack        = "example"
  attributes   = var.attributes
  tags         = var.tags
}

resource "aws_s3_bucket" "example" {
  count = module.context.enabled ? 1 : 0

  bucket = module.context.id
  tags   = module.context.tags
}
```

#### Inputs

| Name           | Default | Description                                       |
|----------------|:-------:|---------------------------------------------------|
| `enabled`      | `true`  | Flag to enable/disable the creation of resources. |
| `organisation` |  `""`   | The name of the organisation.                     |
| `application`  |  `""`   | The name of the application.                      |
| `account`      |  `""`   | The name of the account.                          |
| `stage`        |  `""`   | The name of the stage.                            |
| `stack`        |  `""`   | The name of the stack.                            |
| `attributes`   |  `[]`   | A list of additional attributes.                  |
| `tags`         |  `{}`   | A map of tags to apply to all resources.          |

#### Outputs

| Name           | Description                                                 |
|----------------|-------------------------------------------------------------|
| `enabled`      | Flag indicating whether the module is enabled.              |
| `organisation` | The normalised name of the organisation.                    |
| `account`      | The normalised name of the account.                         |
| `application`  | The normalised name of the application.                     |
| `stage`        | The normalised name of the stage.                           |
| `stack`        | The normalised name of the stack.                           |
| `attributes`   | A list of normalised additional attributes.                 |
| `tags`         | The normalised map of tags.                                 |
| `context`      | Merged but otherwise unmodified input given to this module. |
| `id`           | The disambiguated ID of the module.                         |

## License

© 2021 [Honest Empire Ltd]  
Made available under the terms of the [Apache License 2.0](LICENSE.md).

[Honest Empire Ltd]: https://www.honestempire.com
[Terraform]: https://www.terraform.io
