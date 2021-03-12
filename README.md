# Terraform context

Terraform module used to enforce naming and tagging conventions.

## Getting started

### Requirements

* [Terraform] 0.14+

### Inputs

| Name          | Default | Description                                    |
| ------------- | :-----: | ---------------------------------------------- |
| `enabled`     | `true`  | Flag to enable/disable the creation of things. |
| `namespace`   | `null`  | Name of the namespace.                         |
| `account`     | `null`  | Name of the account.                           |
| `environment` | `null`  | Name of the environment.                       |
| `thing`       | `null`  | Name of the thing.                             |
| `attributes`  | `[]`    | List of additional attributes.                 |

### Outputs

## License

© 2021 [Honest Empire Ltd]  
Made available under the terms of the [Apache License 2.0](LICENSE.md).

[Honest Empire Ltd]: https://www.honestempire.com
[Terraform]: https://www.terraform.io
