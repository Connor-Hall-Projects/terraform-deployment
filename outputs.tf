# Show the public IP of the EC2 instance after provisioning
output "instance_public_ip" {
  value = aws_instance.web.public_ip
}

# Show the name of the S3 bucket
output "s3_bucket_name" {
  value = aws_s3_bucket.backup.id
}