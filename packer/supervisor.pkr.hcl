packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

source "amazon-ebs" "supervisor" {
  ami_name      = "hws-supervisor-${local.timestamp}"
  instance_type = "t3.micro"
  region        = "us-west-2"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
  tags = {
    Name         = "hws-supervisor-${local.timestamp}"
    X-Production = "True"
    X-Contact    = "Donald.Slanec@progress.com"
  }
}

build {
  name = "Linux-Supervisor"
  sources = [
    "source.amazon-ebs.supervisor"
  ]

  provisioner "file" {
    source      = "files/hab.service"
    destination = "/tmp/hab.service"
  }

  provisioner "file" {
    source      = "files/ip-172-31-54-5.cert"
    destination = "/tmp/ip-172-31-54-5.cert"
  }

  provisioner "file" {
    source      = "files/ip-172-31-54-7.cert"
    destination = "/tmp/ip-172-31-54-7.cert"
  }

  provisioner "shell" {
    environment_vars = [
      "FOO=Bar"
    ]
    inline = [
      "sudo mv /tmp/hab.service /etc/systemd/system/hab.service",
      "curl https://raw.githubusercontent.com/habitat-sh/habitat/main/components/hab/install.sh | sudo bash",
      "sudo hab license accept",
      "sudo mv /tmp/ip-172-31-54-5.cert /hab/cache/ssl/ip-172-31-54-5.cert",
      "sudo mv /tmp/ip-172-31-54-7.cert /hab/cache/ssl/ip-172-31-54-7.cert",
      "sudo mkdir -p /hab/sup/default",
      "sudo groupadd hab",
      "sudo useradd -g hab hab",
      "sudo mkdir /etc/systemd/system/hab.service.d",
      "sudo touch /etc/systemd/system/hab.service.d/override.conf",
      "echo '[Service]' | sudo tee -a /etc/systemd/system/hab.service.d/override.conf",
    ]
  }
}