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

variable "account" {
  description = "The name of the account."
  type        = string

  validation {
    error_message = "The name of the account can contain lowercase letters, numbers, and hyphens."
    condition     = can(regex("^[0-9a-z-]+$", var.account))
  }
}

variable "application" {
  description = "The name of the application."
  type        = string

  validation {
    error_message = "The name of the application can contain lowercase letters, numbers, and hyphens."
    condition     = can(regex("^[0-9a-z-]+$", var.application))
  }
}

variable "environment" {
  default     = null
  description = "The name of the environment."
  type        = string
}

variable "order" {
  default     = ["application", "account", "environment", "stack"]
  description = "List of labels in the order they should be applied."
  type        = list(string)
}

variable "organization" {
  default     = null
  description = "The name of the organization."
  type        = string
}

variable "stack" {
  description = "The name of the stack."
  type        = string

  validation {
    error_message = "The name of the stack can contain lowercase letters, numbers, and hyphens."
    condition     = can(regex("^[0-9a-z-]+$", var.stack))
  }
}
