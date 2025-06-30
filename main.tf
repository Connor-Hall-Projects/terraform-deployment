# Define the AWS provider and region
provider "aws" {
  region = var.region
}

# Create a Virtual Private Cloud (VPC)
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "SimpleVPC"
  }
}

# Create a public subnet within the VPC
resource "aws_subnet" "main" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true  # Automatically assign a public IP to instances

  tags = {
    Name = "MainSubnet"
  }
}

# Attach an Internet Gateway to the VPC so instances can access the internet
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
}

# Create a route table to define internet access rules
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"                # All internet traffic
    gateway_id = aws_internet_gateway.gw.id
  }
}

# Associate the route table with the subnet
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.rt.id
}

# Create a security group to allow web and SSH access
resource "aws_security_group" "web_sg" {
  name        = "web_sg"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip] # Replace with your public IP for safety
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Open to the world (not safe in real prod)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "WebSG"
  }
}

# Launch an EC2 instance (virtual server)
resource "aws_instance" "web" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.main.id
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  associate_public_ip_address = true
  user_data                   = file("user_data.sh") # Bootstraps Apache

  tags = {
    Name = "SimpleWebInstance"
  }
}

# Create an S3 bucket with versioning to simulate backups
resource "aws_s3_bucket" "backup" {
  bucket = var.bucket_name  # Must be globally unique

  versioning {
    enabled = true
  }

  tags = {
    Name        = "TerraformBackups"
    Environment = "Dev"
  }
}
