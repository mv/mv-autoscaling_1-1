
##
## Build + provisioning
##
build {
  sources = [ "source.amazon-ebs.al2023" ]

  provisioner "shell" {
    inline = [
      "echo ===== Install nginx",
      "sudo dnf install -y nginx",
      "sudo systemctl enable nginx",
      "sudo systemctl start  nginx",
      "echo ===",
      "echo ===== Upload files",
      "mkdir -p /tmp/www"
   ]
  }

  # upload dir
  provisioner "file" {
    sources     = [ "./files/" ]
    destination = "/tmp/www/"
  }

  # example: define a custom 'release'
  provisioner "shell" {
    inline = [
      "echo ===== Define release: [${var.release}]",
      "cd /tmp/www/ && /bin/cp index-${var.release}.html index.html",
    ]
  }

  # install
  provisioner "shell" {
    inline = [
      "echo ===== Copy files: /usr/share/nginx/html/",
      "sudo /bin/cp /tmp/www/* /usr/share/nginx/html/",
    ]
  }

  ##
  ## Breakpoint: check provisioning before commiting a new AMI
  ##
  /*****
  provisioner "breakpoint" {
    disable = false
    note    = "Breakpoint: check provisioning...."
  }
  /*****/

}
