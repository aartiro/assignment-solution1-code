provider "aws" {
  region  = var.region
  profile = "saml"
}

# resource block for ec2
resource "aws_instance" "app" {
  for_each        = data.aws_subnet_ids.private.ids
  ami             = data.aws_ami.amazon_linux_2.id
  instance_type   = var.instance_type
  subnet_id       = each.value
  security_groups = [aws_security_group.allow_tls.id]
  tags = {
    Name     = "App Server"
    Activity = "App Server for Roche Patho"
  }
}

# resource block for eip
resource "aws_eip" "myeip" {
  vpc = true
}

# resource block for ec2 and eip association
resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.app.id
  allocation_id = aws_eip.myeip.id
}

# resource creation for security group
resource "aws_security_group" "allow_tls" {
  name        = "app-security-group"
  description = "Allow TLS inbound traffic to Roche Office"
  vpc_id      = data.aws_vpc.main_vpc.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["191.40.1.0/24 "]
  }

  #   egress {
  #     from_port       = 0
  #     to_port         = 0
  #     protocol        = "-1"
  #     cidr_blocks     = ["0.0.0.0/0"]
  #   }
}
