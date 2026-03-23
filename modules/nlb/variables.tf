
variable "nlb_name" { default = "nlb-bg-01" }

variable "vpc_id"  {}

variable "subnets" {
  type = list(string)
  default = []
}

variable "enable_deletion_protection" {
  type        = bool
  default     = false
}

variable "health_check" {
  type    = map(string)
  default = {}
}

variable "tags" {
  type    = map(string)
  default = {}
}
