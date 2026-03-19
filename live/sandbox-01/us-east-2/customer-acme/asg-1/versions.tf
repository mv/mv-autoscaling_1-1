# vscode-modelines
# vim: set ft=terraform:

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 6.36.0"
#     version = "~> 5.0"
    }
  }
}
