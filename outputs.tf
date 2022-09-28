// Copyright © 2021 Daniel Morris.
// All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at:
//
// https://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

output "account" {
  description = "The normalised name of the account."
  value       = local.account
}

output "application" {
  description = "The normalised name of the application."
  value       = local.application
}

output "attributes" {
  description = "A list of normalised additional attributes."
  value       = local.attributes
}

output "context" {
  description = "Merged but otherwise unmodified input given to this module."
  value       = local.input
}

output "id" {
  description = "The disambiguated ID of the module."
  value       = local.id
}

output "organisation" {
  description = "The normalised name of the organisation."
  value       = local.organisation
}

output "path" {
  description = "The disambiguated ID of the module delimited with slashes."
  value       = local.path
}

output "stack" {
  description = "The normalised name of the stack."
  value       = local.stack
}

output "stage" {
  description = "The normalised name of the stage."
  value       = local.stage
}

output "tags" {
  description = "A normalised map of tags."
  value       = local.tags
}
