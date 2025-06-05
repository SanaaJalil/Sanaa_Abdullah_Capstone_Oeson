# main.tf placeholder
# VPC
resource "aws_vpc" "devops_vpc" {
  cidr_block = var.vpc_cidr
}

# Subnets
resource "aws_subnet" "subnet_a" {
  vpc_id     = aws_vpc.devops_vpc.id
  cidr_block = var.subnet_a_cidr
  availability_zone = "us-west-2a"
}

resource "aws_subnet" "subnet_b" {
  vpc_id     = aws_vpc.devops_vpc.id
  cidr_block = var.subnet_b_cidr
  availability_zone = "us-west-2b"
}

# Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.devops_vpc.id
}

# Route Table
resource "aws_route_table" "r" {
  vpc_id = aws_vpc.devops_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

# Route Table Associations
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet_a.id
  route_table_id = aws_route_table.r.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.subnet_b.id
  route_table_id = aws_route_table.r.id
}

# Security Group
resource "aws_security_group" "allow_traffic" {
  vpc_id = aws_vpc.devops_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
  from_port   = 6443
  to_port     = 6443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
# Jenkins EC2
resource "aws_instance" "jenkins" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.subnet_a.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.allow_traffic.id]
  key_name                    = var.key_name # 🔑 add key pair

  tags = {
    Name = "jenkins"
  }
}

# Kubernetes Node 1
resource "aws_instance" "k8s_node_1" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.subnet_b.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.allow_traffic.id]
  key_name                    = var.key_name # 🔑 add key pair

  tags = {
    Name = "k8s-node-1"
  }
}

# Kubernetes Node 2
resource "aws_instance" "k8s_node_2" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.subnet_a.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.allow_traffic.id]
  key_name                    = var.key_name    # 🔑 add key pair

  tags = {
    Name = "k8s-node-2"
  }
}
