provider "aws" {
  region = "us-east-1"
  profile = "personal"

}

locals {
  serverconfig = [
    for srv in var.configuration : [
      for i in range(1, srv.no_of_instances+1) : {
        instance_name = "${srv.application_name}-${i}"
        instance_type = srv.instance_type
        subnet_id   = srv.subnet_id
        ami = srv.ami
        rootdisk = srv.root_block_device
        blockdisks = [
          for block in srv.ebs_block_devices : {
            device_name = block.device_name
            volume_type = block.volume_type
            volume_size = block.volume_size
            tags = block.tags
          }   
        ]
        securitygroupids = srv.vpc_security_group_ids
      }
    ]
  ]
}

// We need to Flatten it before using it
locals {
  instances = flatten(local.serverconfig)
}

resource "aws_instance" "web" {

  for_each = {for server in local.instances: server.instance_name =>  server}
  
  ami           = each.value.ami
  instance_type = each.value.instance_type
  vpc_security_group_ids = each.value.securitygroupids
  key_name =  "Sarav-Easy"
  associate_public_ip_address = true
  user_data = "${file("init.sh")}"
  subnet_id = each.value.subnet_id
  tags = {
    Name = "${each.value.instance_name}"
  }  
  root_block_device {
      volume_type = each.value.rootdisk.volume_type
      volume_size = each.value.rootdisk.volume_size
      tags = each.value.rootdisk.tags
    }

  dynamic "ebs_block_device"{
    for_each = each.value.blockdisks
    content {
      volume_type = ebs_block_device.value.volume_type
      volume_size = ebs_block_device.value.volume_size
      tags = ebs_block_device.value.tags
      device_name = ebs_block_device.value.device_name
    }
  }
  
}
output "instances" {
  value       = "${aws_instance.web}"
  description = "All Machine details"
}
