# Terraform Deployment

This project provisions a basic but production-style cloud infrastructure on Amazon Web Services (AWS) using [Terraform](https://www.terraform.io/). It deploys a fully functional web server accessible over the internet, along with a versioned S3 bucket for simulated backup or storage use cases.

The goal is to demonstrate Infrastructure as Code (IaC), security best practices, and foundational AWS resource management.


## 🌐 What This Project Deploys

| Layer        | Resource                               | Purpose |
|--------------|----------------------------------------|---------|
| Networking   | VPC, Subnet, Internet Gateway, Route Table | Creates an isolated and routable AWS network |
| Security     | Security Group                         | Controls inbound SSH and HTTP access |
| Compute      | EC2 Instance                           | Hosts an Apache-based web server |
| Storage      | S3 Bucket (versioned)                  | Simulates backup storage with versioning |
| Automation   | User Data script                       | Installs and configures Apache on launch |
| Outputs      | Terraform Outputs                      | Displays EC2 public IP and S3 bucket name |

---

## Architecture Overview
main.tf # Main infrastructure configuration

variables.tf # Input variables (e.g., region, instance type)

outputs.tf # Exposes public IP and S3 bucket name

user_data.sh # Bootstraps Apache on EC2

## How to Deploy

1. Bash
   
   ``` git clone https://github.com/Connor-Hall-Projects/terraform-deployment```

   ```cd terraform-simple-deploy```

2. Edit variables.tf to set: region, instance_type, bucket_name, my_ip

3. Initialize Terraform
``` terraform init ```

4. Preview the changes
``` terraform plan ```

5. Apply the infrastructure
``` terraform apply ```

## Usage

Once deployed, Terraform will output the EC2 instance’s public IP. Visit in your browser (ex. http://34.123.45.67)

🪣 About the S3 Bucket

The S3 bucket is versioned, simulating a backup target or cloud archive. While this version doesn’t push files to S3, future updates may include backup scripts or log uploads from EC2 to S3.

## Removal

To remove everything (and avoid charges): ``` terraform destroy ```
