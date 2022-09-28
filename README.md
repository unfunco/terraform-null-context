# Terraform context module

![CI](https://github.com/unfunco/terraform-null-context/actions/workflows/ci.yaml/badge.svg)

Terraform module for generating consistent naming and tagging conventions.

## Getting started

### Requirements

* [Terraform] 1.3+

### Installation and usage

The following documentation demonstrates the recommended way to use this module.

```terraform
module "context" {
  source = "git::git@github.com:unfunco/terraform-null-context.git?ref=main"

  organisation = var.organisation
  application  = var.application
  account      = var.account
  environment  = var.environment
  stack        = var.stack
  attributes   = var.attributes
  tags         = var.tags
}
```

```json
{
  "organisation": "Honest Empire",
  "application": "Serious Balls",
  "account": "Live",
  "environment": "Live",
  "stack": "website"
}
```

```terraform
resource "aws_s3_bucket" "website" {
  bucket = module.context.id
  tags   = module.context.tags
}
```

```terraform
website_bucket_id = "seriousballs-live-website"

website_bucket_tags = tomap({
  "Account"      = "live"
  "Application"  = "example"
  "Organisation" = "honestempire"
  "Stack"        = "website"
  "Environment"  = "live"
})
```

#### Variables

| Name           | Default | Description                              |
|----------------|:-------:|------------------------------------------|
| `organisation` |  `""`   | The name of the organisation.            |
| `application`  |  `""`   | The name of the application.             |
| `account`      |  `""`   | The name of the account.                 |
| `environment`  |  `""`   | The name of the environment.             |
| `stack`        |  `""`   | The name of the stack.                   |
| `attributes`   |  `[]`   | A list of additional attributes.         |
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
| `attributes`   | A list of normalised additional attributes.                     |
| `tags`         | The normalised map of tags.                                     |
| `context`      | The merged but otherwise unmodified input given to this module. |

## License

© 2021 [Daniel Morris]  
Made available under the terms of the [Apache License 2.0](LICENSE.md).

[Daniel Morris]: https://unfun.co
[Honest Empire Ltd]: https://www.honestempire.com
[Terraform]: https://www.terraform.io
