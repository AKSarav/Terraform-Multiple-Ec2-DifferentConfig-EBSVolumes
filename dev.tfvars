configuration = [
  {
    "application_name" : "GritfyAppDev",
    "ami" : "ami-0c02fb55956c7d316",
    "no_of_instances" : "2",
    "instance_type" : "t3a.nano",
    "subnet_id" : "subnet-0f4f294d8404946eb",
    "vpc_security_group_ids" : ["sg-0d15a4cac0567478c","sg-0d8749c35f7439f3e"],
    "root_block_device": {
      "volume_size": "30",
      "volume_type": "gp3"
      "tags": {
        "FileSystem": "/root"
      }
    }
    "ebs_block_devices":[
      {
        "device_name" : "/dev/xvdba"
        "volume_size": "10"
        "volume_type": "gp3"
        "tags": {
          "FileSystem": "/hana/data"
        }
      },
      {
        "device_name" : "/dev/xvdbb"
        "volume_size": "20"
        "volume_type": "gp3"
        "tags": {
          "FileSystem": "/hana/log"
        }
      },
      {
        "device_name" : "/dev/xvdbc"
        "volume_size": "20"
        "volume_type": "gp3"
        "tags": {
          "FileSystem": "/hana/shared"
        }
      },
    ]
  },
  {
    "application_name" : "GritfyWebDev",
    "ami" : "ami-0c02fb55956c7d316",
    "no_of_instances" : "2",
    "instance_type" : "t3a.nano",
    "subnet_id" : "subnet-0f4f294d8404946eb",
    "vpc_security_group_ids" : ["sg-0d15a4cac0567478c","sg-0d8749c35f7439f3e"],
    "root_block_device": {
      "volume_size": "30",
      "volume_type": "gp3"
      "tags": {
        "FileSystem": "/root"
      }
    }
    "ebs_block_devices":[
      {
        "device_name" : "/dev/xvdba"
        "volume_size": "10"
        "volume_type": "gp3"
        "tags": {
          "FileSystem": "/web/data"
        }
      },
      {
        "device_name" : "/dev/xvdbc"
        "volume_size": "20"
        "volume_type": "gp3"
        "tags": {
          "FileSystem": "/web/shared"
        }
      },
    ]
  }
]