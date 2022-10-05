# Changelog

Notable changes to this project are documented in this changelog.  
This project adheres to the [semantic versioning] specification.

## [0.2.0] – 2022-10-05

* Removed the `enabled` variable because it felt wrong.
* Removed the `attributes` variable because I never used it.
* Renamed the `stage` variable to `environment` because it felt right.
* Renamed the `example` directory to `examples` as that is what is required by
  the Terraform registry.

## [0.1.1] – 2021-12-28

* Fixed the missing stage variable in the outputs.

## [0.1.0] – 2021-10-22

* Initial release.

[0.1.0]: https://github.com/unfunco/terraform-null-context/releases/tag/v0.1.0
[0.1.1]: https://github.com/unfunco/terraform-null-context/compare/v0.1.0...v0.1.1
[0.2.0]: https://github.com/unfunco/terraform-null-context/compare/v0.1.1...v0.2.0
[Semantic versioning]: https://semver.org
