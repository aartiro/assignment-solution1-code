data "aws_vpc" "main_vpc" {
  tags = {
    Name    = "Main VPC"
    Project = "Roche Patho"
  }
}

data "aws_subnet_ids" "private" {
  vpc_id = data.aws_vpc.main_vpc.id

  tags = {
    Tier = "Private"
  }
}

data "aws_ami" "amazon_linux_2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}