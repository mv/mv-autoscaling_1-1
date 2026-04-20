
variable "key_name" {}
variable "ssm_path" {}

variable "tags" {
  type    = map(string)
  default = {}
}
