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
  default     = ""
  description = "The name of the account."
  type        = string
}

variable "application" {
  default     = ""
  description = "The name of the application."
  type        = string
}

variable "context" {
  default = {
    organisation = ""
    application  = ""
    account      = ""
    environment  = ""
    stack        = ""
    tags         = {}
  }

  description = "Single object used for setting the entire context at once."

  type = object({
    organisation = optional(string)
    application  = string
    account      = string
    environment  = optional(string)
    stack        = string
    tags         = optional(map(string))
  })
}

variable "environment" {
  default     = ""
  description = "The name of the environment."
  type        = string
}

variable "label_order" {
  default     = ["application", "account", "environment", "stack"]
  description = "List of labels in the order they should be applied."
  type        = list(string)
}

variable "organisation" {
  default     = ""
  description = "The name of the organisation."
  type        = string
}

variable "path_order" {
  default     = ["application", "account", "environment", "stack"]
  description = "List of path components in the order they should be applied."
  type        = list(string)
}

variable "stack" {
  default     = ""
  description = "The name of the stack."
  type        = string
}

variable "tags" {
  default     = {}
  description = "Map of tags to be applied to resources."
  type        = map(string)
}
