# Default AWS region
variable "region" {
  default = "us-east-1"
}

# EC2 instance type (t2.micro = free tier eligible)
variable "instance_type" {
  default = "t2.micro"
}

# AMI ID for Amazon Linux 2 in us-east-1
variable "ami_id" {
  default = "ami-0c02fb55956c7d316"
}

# S3 bucket name (must change to be globally unique)
variable "bucket_name" {
  default = "my-simple-tf-bucket-connor2025"
}

# Your IP address or IP range to allow SSH from
variable "my_ip" {
  description = "Your public IP for SSH access"
  default     = "0.0.0.0/0"  # Replace with your IP like "203.0.113.0/32"
}
