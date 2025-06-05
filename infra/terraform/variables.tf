
# AWS region where resources will be created
variable "region" {
  default = "us-west-2"
}

# The AMI ID for Amazon Linux 2023 (or your preferred base image)
variable "ami_id" {
  default = "ami-04999cd8f2624f834"  # Replace with your AMI if needed
}

# Instance type for Jenkins and Kubernetes nodes
variable "instance_type" {
  default = "t2.micro"
}

# CIDR block for the VPC
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

# CIDR blocks for two public subnets
variable "subnet_a_cidr" {
  default = "10.0.1.0/24"
}

variable "subnet_b_cidr" {
  default = "10.0.2.0/24"
}

# Key pair name for EC2 instance
variable "key_name" {
  description = "Name of the Key Pair to SSH into EC2 instances"
  type        = string
}

# Your IP address to allow SSH access
variable "my_ip" {
  description = "Your public IP address for SSH (format: x.x.x.x/32)"
  type        = string
}

