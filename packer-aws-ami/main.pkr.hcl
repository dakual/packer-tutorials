variable "ami_id" {
  type    = string
  default = "ami-0e7e134863fac4946"
}

variable "app_name" {
  type    = string
  default = "httpd"
}

source "amazon-ebs" "httpd" {
  ami_name      = "my-image-${var.app_name}"
  instance_type = "t2.micro"
  region        = "eu-central-1"
  source_ami    = "${var.ami_id}"
  ssh_username  = "ec2-user"
  tags = {
    Env  = "development"
    Name = "my-image-${var.app_name}"
  }
}

build {
  sources = ["source.amazon-ebs.httpd"]

  provisioner "shell" {
    script = "script/install-httpd.sh"
  }

  post-processor "shell-local" {
    inline = ["echo Hello"]
  }
}

