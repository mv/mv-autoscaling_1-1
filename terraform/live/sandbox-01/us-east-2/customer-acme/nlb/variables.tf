
variable "customer" { default = "customer"  }
variable "nlb_name" { default = "nlb-customer-01" }

variable "vpc_id"  {}

variable "subnets" {
  type = list(string)
  default = []
}
