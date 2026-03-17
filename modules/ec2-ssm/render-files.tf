
resource "local_file" "ssm_conn_info" {
  count = var.create_scripts ? 1 : 0

  filename        = "${var.output_dir}/ssm-conn-info.sh"
  content         = templatefile("${var.source_dir}/tmpl/ssm-conn-info.sh", { placeholder = var.ssm_connection_info })
  file_permission = "0775"
}

resource "local_file" "ssm_port_forward" {
  count = var.create_scripts ? 1 : 0

  filename = "${var.output_dir}/ssm-port-forward.sh"
  content = templatefile(
    "${var.source_dir}/tmpl/ssm-port-forward.sh",
    {
      placeholder = var.ssm_connection_info
      instance_id = module.ec2.id
    }
  )
  file_permission = "0775"
}

resource "local_file" "ssm_session" {
  count = var.create_scripts ? 1 : 0

  filename        = "${var.output_dir}/ssm-session.sh"
  content         = templatefile("${var.source_dir}/tmpl/ssm-session.sh", { instance_id = module.ec2.id })
  file_permission = "0775"
}
