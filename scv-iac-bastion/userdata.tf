
data "template_file" "bastion_init" {
  
  template = file("./lib/bastion.sh.tpl")

  vars = {
    someVariable = "88"
  }
  
}


# # https://www.terraform.io/docs/configuration/expressions.html#string-literals
# locals {
#   userdata = <<-USERDATA
#     #!/bin/bash
#     cat <<"__EOF__" > /home/ec2-user/.ssh/config
#     Host *
#         StrictHostKeyChecking no
#     __EOF__
#     chmod 600 /home/ec2-user/.ssh/config
#     chown ec2-user:ec2-user /home/ec2-user/.ssh/config
#   USERDATA
# }