// Copyright © 2021 Honest Empire Ltd.
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

variable "attributes" {
  default     = []
  description = "A list of additional attributes."
  type        = list(string)
}

variable "context" {
  default = {
    account      = ""
    application  = ""
    attributes   = []
    enabled      = true
    organisation = ""
    stack        = ""
    stage        = ""
    tags         = {}
  }

  description = "Single object used for setting the entire context at once."

  type = object({
    account      = string
    application  = string
    attributes   = list(string)
    enabled      = bool
    organisation = string
    stack        = string
    stage        = string
    tags         = object({})
  })
}

variable "enabled" {
  default     = true
  description = "Flag to enable/disable the creation of resources."
  type        = bool
}

variable "label_order" {
  default     = ["application", "account", "stage", "stack", "attributes"]
  description = "List of labels in the order they should be applied."
  type        = list(string)
}

variable "organisation" {
  default     = ""
  description = "The name of the organisation."
  type        = string
}

variable "path_order" {
  default     = ["application", "account", "stage"]
  description = "List of path components in the order they should be applied."
  type        = list(string)
}

variable "stack" {
  default     = ""
  description = "The name of the stack."
  type        = string
}

variable "stage" {
  default     = ""
  description = "The name of the stage."
  type        = string
}

variable "tags" {
  default     = {}
  description = "Map of tags to be applied to resources."
  type        = object({})
}
