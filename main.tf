# Retrieves the latest Ubuntu Linux AMI on AWS
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

  # allow incoming traffic from any IP address to the SG
  ingress_cidr_blocks = ["0.0.0.0/0"]

  # Allow incoming traffic on port 22
  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "SSH Access"
      cidr_blocks = "0.0.0.0/0"
    },
    # Allow incoming traffic on port 80
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "Http access"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
  # Allow all outgoing traffic
  egress_rules = ["all-all"]
}

# Terraform module creates an EC2 instance with specified configurations.
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

# Creates an Elastic IP and associates it with EC2 instance created in the previous module.
resource "aws_eip" "challenge-ip" {
  instance = module.challenge_ec2_instance.id
  vpc      = true
}

# Create an output that displays the Public IP
output "challenge_aws_elastic_ip_grafana" {
  value       = "http://${aws_eip.challenge-ip.public_ip} <<< Grafana's Public IP, please wait about 2 minutes to script finish." 
  description = "Public IP address of the Grafana instance"
}
