# Data source for Amazon Linux 2 AMI
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Key pair
resource "aws_key_pair" "kingsly" {
  key_name   = var.key_name
  public_key = file("~/.ssh/id_rsa.pub")
}

# Frontend EC2 Instance (Vote + Result apps)
resource "aws_instance" "frontend" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.frontend.id]
  key_name               = aws_key_pair.kingsly.key_name

  associate_public_ip_address = true

  tags = {
    Name = "kingsly-frontend-${var.environment}"
    Role = "frontend"
  }
}

# Backend EC2 Instance (Redis + Worker)
resource "aws_instance" "backend" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.backend.id]
  key_name               = aws_key_pair.kingsly.key_name

  associate_public_ip_address = false

  tags = {
    Name = "kingsly-backend-${var.environment}"
    Role = "backend"
  }
}

# Database EC2 Instance (PostgreSQL)
resource "aws_instance" "database" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.database.id]
  key_name               = aws_key_pair.kingsly.key_name

  associate_public_ip_address = false

  tags = {
    Name = "kingsly-database-${var.environment}"
    Role = "database"
  }
}

# Dedicated Bastion Host
resource "aws_instance" "bastion" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.bastion.id]
  key_name               = aws_key_pair.kingsly.key_name
  associate_public_ip_address = true

  user_data = <<-EOF
    #!/bin/bash
    sudo amazon-linux-extras install ansible2 -y
    sudo yum install -y git docker
    sudo service docker start
    sudo usermod -a -G docker ec2-user
  EOF

  tags = {
    Name = "kingsly-bastion-${var.environment}"
    Role = "bastion"
  }
}

# Security Group for Bastion
resource "aws_security_group" "bastion" {
  name        = "kingsly-bastion-sg-${var.environment}"
  description = "Security group for bastion host"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH from anywhere"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "kingsly-bastion-sg"
  }
}

# Frontend Instance in AZ1 (us-east-1a)
resource "aws_instance" "frontend_az1" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.frontend.id]
  key_name               = aws_key_pair.kingsly.key_name
  associate_public_ip_address = true

  user_data = <<-EOF
    #!/bin/bash
    sudo amazon-linux-extras install docker -y
    sudo service docker start
    sudo usermod -a -G docker ec2-user
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
  EOF

  tags = {
    Name = "kingsly-frontend-az1-${var.environment}"
    Role = "frontend"
    AZ   = "us-east-1a"
  }
}

# Frontend Instance in AZ2 (us-east-1b)
resource "aws_instance" "frontend_az2" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public2.id
  vpc_security_group_ids = [aws_security_group.frontend.id]
  key_name               = aws_key_pair.kingsly.key_name
  associate_public_ip_address = true

  user_data = <<-EOF
    #!/bin/bash
    sudo amazon-linux-extras install docker -y
    sudo service docker start
    sudo usermod -a -G docker ec2-user
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
  EOF

  tags = {
    Name = "kingsly-frontend-az2-${var.environment}"
    Role = "frontend"
    AZ   = "us-east-1b"
  }
}
