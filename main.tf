data "aws_ami" "ubuntu_linux" {

    most_recent = true

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }

    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }

    owners = ["099720109477"]
}

module "challenge_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "challenge-sg"
  description = "Challenge server Security group"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["all-all"]
  egress_rules        = ["all-all"]
}

module "challenge_ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "Challenge-Server"

  ami                    = data.aws_ami.ubuntu_linux.id
  instance_type          = "t3.large"
  key_name               = "vockey"
  monitoring             = true
  vpc_security_group_ids = [module.challenge_sg.security_group_id]
  subnet_id              = module.vpc.public_subnets[0]
  iam_instance_profile   = "LabInstanceProfile"
  user_data              = local.dependencies_script

  tags = {
    Terraform = "true"
  }
}

resource "aws_eip" "challenge-ip" {
  instance = module.challenge_ec2_instance.id
  vpc      = true
}

output "challenge_aws_elastic_ip_grafana" {
  value       = "http://${aws_eip.challenge-ip.public_ip}" #grafana server ip
  description = "Public IP address of the Grafana instance"
}
