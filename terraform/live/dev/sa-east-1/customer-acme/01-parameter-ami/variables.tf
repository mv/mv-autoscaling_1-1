
variable "customer" { default = "acme" }
variable "ssm_path" { default = "/app/asg/ami"   }

variable "ami_id"   { default = "" }


# self discovery (using ../common.auto.tfvars)
variable "ami_owners" { default = "" }
variable "ami_name"   { default = "" }
