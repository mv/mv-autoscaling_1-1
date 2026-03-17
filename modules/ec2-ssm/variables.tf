
variable "name"          { default = "ssm-server" }
variable "instance_type" { default = "t3.micro"   }
variable "subnet_id"     {}

variable "root_block_device" {
  type = object({
    delete_on_termination = optional(bool)
    encrypted             = optional(bool)
    iops                  = optional(number)
    kms_key_id            = optional(string)
    tags                  = optional(map(string))
    throughput            = optional(number)
    size                  = optional(number)
    type                  = optional(string)
  })
  default = {}
}

variable "key_name"     { default = null }
variable "key_ssm_path" { default = null }

variable "db_security_group_id" { default = null }
variable "ssm_connection_info"  { default = null }

variable "create_scripts" { default = false  }
variable "output_dir"     { default = "" }
variable "source_dir"     { default = "" }

variable "tags" {
  type    = map(string)
  default = {}
}
