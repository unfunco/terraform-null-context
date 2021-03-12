# Terraform context

Terraform module used to enforce Honest Empire naming and tagging conventions.

## Getting started

### Requirements

* [Terraform] 0.14+

### Installation and usage

```bash
module "this" {
  source = "git::git@github.com:honestempire/terraform-null-context.git?ref=main"

  enabled     = var.enabled
  namespace   = var.namespace
  account     = var.account
  environment = var.environment
  component   = var.component
  attributes  = var.attributes
  tags        = var.tags
}
```

#### Inputs

| Name          | Default | Description                                       |
| ------------- | :-----: | ------------------------------------------------- |
| `enabled`     | `true`  | Flag to enable/disable the creation of resources. |
| `namespace`   | `null`  | Name of the namespace.                            |
| `account`     | `null`  | Name of the account.                              |
| `environment` | `null`  | Name of the environment.                          |
| `component`   | `null`  | Name of the component.                            |
| `attributes`  | `[]`    | List of attributes.                               |
| `tags`        | `{}`    | Map of tags.                                      |

#### Outputs

| Name          | Description                                                 |
| ------------- | ----------------------------------------------------------- |
| `account`     | Normalised name of the account.                             |
| `attributes`  | List of normalised additional attributes.                   |
| `component`   | Normalised name of the component.                           |
| `context`     | Merged but otherwise unmodified input given to this module. |
| `enabled`     | Flag indicating whether the module is enabled.              |
| `environment` | Normalised name of the environment.                         |
| `id`          | Disambiguated ID of the module.                             |
| `namespace`   | Normalised name of the namespace.                           |
| `tags`        | Normalised map of tags.                                     |

## License

© 2021 [Honest Empire Ltd]  
Made available under the terms of the [Apache License 2.0](LICENSE.md).

[Honest Empire Ltd]: https://www.honestempire.com
[Terraform]: https://www.terraform.io
