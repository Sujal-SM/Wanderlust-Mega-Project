# Wanderlust Mega Project - Terraform Infrastructure

This Terraform configuration deploys the infrastructure for the Wanderlust application on AWS.

## Architecture

- **Default VPC**: Uses AWS default VPC for simplicity
- **EC2 Instance**: Single instance for hosting the application
- **Security Group**: Allows traffic on ports 22, 80, 443, 3000, 5000
- **SSH Key Pair**: For secure access to EC2 instance

## Prerequisites

- AWS CLI configured with appropriate credentials
- Terraform installed (compatible with AWS provider 6.17.0)
- SSH key pair generated (`test-pair-wanderlust` and `test-pair-wanderlust.pub`)

## Quick Start

1. **Initialize Terraform**
   ```bash
   terraform init
   ```

2. **Validate Configuration**
   ```bash
   terraform validate
   ```

3. **Plan Deployment**
   ```bash
   terraform plan
   ```

4. **Deploy Infrastructure**
   ```bash
   terraform apply
   ```
   Or for automated deployment:
   ```bash
   terraform apply -auto-approve
   ```
   
## Configuration

### Variables

| Variable | Description | Default | Type |
|----------|-------------|---------|------|
| `aws_region` | AWS region for deployment | `ap-south-1` | string |
| `project_name` | Project name for resource naming | `wanderlust-mega-project` | string |
| `ec2_ami_id` | AMI ID for EC2 instance | `ami-02d26659fd82cf299` | string |
| `ec2_instance_type` | EC2 instance type | `t3.micro` | string |
| `volume_size` | Root EBS volume size (GB) | `20` | number |
| `volume_type` | EBS volume type | `gp3` | string |

### Outputs

- `instance_id`: EC2 instance ID
- `instance_public_ip`: Public IP address
- `instance_public_dns`: Public DNS name
- `security_group_id`: Security group ID

## Security Ports

- **22**: SSH access
- **80**: HTTP traffic
- **443**: HTTPS traffic
- **3000**: Frontend application
- **5000**: Backend API

## Files

- `main.tf`: Main infrastructure resources
- `variables.tf`: Input variables
- `outputs.tf`: Output values
- `provider.tf`: AWS provider configuration
- `versions.tf`: Terraform and provider versions
- `locals.tf`: Local values and tags

## Clean Up

```bash
terraform destroy -auto-approve
```
This command will remove all resources created by this Terraform configuration.