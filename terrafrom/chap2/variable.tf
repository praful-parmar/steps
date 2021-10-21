#************variable*************#
# variable "env" {
#   type        = string
#   default     = "dev"
#   description = "env to deployment"
# }

variable "image" {
  type        = map(any)
  description = "image for container"
  default = {
    dev  = "nodered/node-red:latest"
    prod = "nodered/node-red:latest-minimal"
  }
}

variable "intport" {
  type    = number
  default = 1880
  validation {
    condition     = var.intport == 1880
    error_message = "The internal port must be 1880."
  }
  #sensitive = true
}

variable "extport" {
  type = map(any)

  validation {
    condition     = max(var.extport["dev"]...) <= 65535 && min(var.extport["dev"]...) >= 1980
    error_message = "The port must between 1980 - 65535."
  }
  validation {
    condition     = max(var.extport["prod"]...) < 1980 && min(var.extport["prod"]...) >= 1880
    error_message = "The port must between 1880 -1980."
  }
  #sensitive = true
}

locals {
  container_count = length(var.extport[terraform.workspace])
}