
variable "customer" { default = "customer"  }

variable "vpc_id"  {}

variable "subnets" {
  type = list(string)
  default = []
}
