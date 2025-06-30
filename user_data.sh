#!/bin/bash

# Update packages and install Apache (httpd)
yum update -y
yum install -y httpd

# Start and enable Apache
systemctl start httpd
systemctl enable httpd

# Set a basic homepage
echo "<h1>Terraform deployed my web server!</h1>" > /var/www/html/index.html