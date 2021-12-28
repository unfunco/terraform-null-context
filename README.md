# Terraform context module

Terraform module for enforcing consistent naming and tagging conventions. This
module is not tied to any specific Cloud provider but the output it produces and
the conventions it applies are currently targeted towards AWS resources. When
using the context module, resources are disambiguated so that multiple instances
of the same resource can exist within a AWS single account, however, it is
recommended to split resources into separate live and non-live AWS accounts.

## Getting started

### Requirements

* [Terraform] 1.0+

### Installation and usage

The following documentation demonstrates the recommended way to use this module.

```terraform
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
```

```json
{
  "enabled": true,
  "organisation": "Honest Empire",
  "application": "TikiTaka",
  "account": "Live",
  "stage": "Live",
  "stack": "website"
}
```

```terraform
resource "aws_s3_bucket" "website" {
  count = module.context.enabled ? 1 : 0

  bucket = module.context.id
  tags   = module.context.tags
}
```

```terraform
website_bucket_id = "tikitaka-live-website"

website_bucket_tags = tomap({
  "Account" = "live"
  "Application" = "example"
  "Organisation" = "honestempire"
  "Stack" = "website"
  "Stage" = "live"
})
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

The outputs have been separated into two tables, the first table contains the
outputs that are most likely to be provided as inputs to other resources. The ID
output is a hyphenated concatenation of the application, account, stage and
stack inputs, and can be used for resource names, the path is slash-delimited,
and can be used for SSM parameter prefixes, for example.

| Name           | Description                                                 |
|----------------|-------------------------------------------------------------|
| `id`           | The disambiguated ID of the module.                         |
| `path`         | The disambiguated ID delimited with slashes.                |

The next table contains the outputs that are really just normalised versions of
the input variables.

| Name           | Description                                                     |
|----------------|-----------------------------------------------------------------|
| `enabled`      | Flag indicating whether the module is enabled.                  |
| `organisation` | The normalised name of the organisation.                        |
| `application`  | The normalised name of the application.                         |
| `account`      | The normalised name of the account.                             |
| `stage`        | The normalised name of the stage.                               |
| `stack`        | The normalised name of the stack.                               |
| `attributes`   | A list of normalised additional attributes.                     |
| `tags`         | The normalised map of tags.                                     |
| `context`      | The merged but otherwise unmodified input given to this module. |

## License

© 2021 [Honest Empire Ltd]  
Made available under the terms of the [Apache License 2.0](LICENSE.md).

[Honest Empire Ltd]: https://www.honestempire.com
[Terraform]: https://www.terraform.io
