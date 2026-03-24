
##
## Build + provisioning
##
build {
  sources = [ "source.amazon-ebs.al2023" ]

  provisioner "shell" {
    inline = [
      "echo ===",
      "echo ===",
      "echo === Connected via SSM at [${build.User}@${build.Host}:${build.Port}]",
      "echo ===",
      "echo ===",
      "sudo yum install -y htop wget"
   ]
  }
}