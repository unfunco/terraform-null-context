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

variable "context" {
  default = {
    enabled     = true
    namespace   = null
    account     = null
    environment = null
    component   = null
    attributes  = []
    tags        = {}
  }

  description = "Single object used for setting the entire context at once."

  type = object({
    enabled     = bool
    namespace   = string
    account     = string
    environment = string
    component   = string
    attributes  = list(string)
    tags        = map(string)
  })
}

variable "enabled" {
  default     = null
  description = "Flag to enable/disable the creation of resources."
  type        = bool
}

variable "namespace" {
  default     = null
  description = "Name of the namespace."
  type        = string
}

variable "account" {
  default     = null
  description = "Name of the account."
  type        = string
}

variable "environment" {
  default     = null
  description = "Name of the environment."
  type        = string
}

variable "component" {
  default     = null
  description = "Name of the component."
  type        = string
}

variable "attributes" {
  default     = []
  description = "List of additional attributes."
  type        = list(string)
}

variable "tags" {
  default     = {}
  description = "Map of tags to be applied to resources."
  type        = map(string)
}
