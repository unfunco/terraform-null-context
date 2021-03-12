// Copyright © 2021 Honest Empire Ltd
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
  description = "Normalised name of the account."
  value       = local.enabled ? local.account : ""
}

output "attributes" {
  description = "List of normalised additional attributes."
  value       = local.enabled ? local.attributes : []
}

output "component" {
  description = "Normalised name of the component."
  value       = local.enabled ? local.component : ""
}

output "context" {
  description = "Merged but otherwise unmodified input given to this module."
  value       = local.input
}

output "enabled" {
  description = "Flag indicating whether the module is enabled."
  value       = local.enabled
}

output "environment" {
  description = "Normalised name of the environment."
  value       = local.enabled ? local.environment : ""
}

output "id" {
  description = "Disambiguated ID of the module."
  value       = local.enabled ? local.id : ""
}

output "namespace" {
  description = "Normalised name of the namespace."
  value       = local.enabled ? local.namespace : ""
}
