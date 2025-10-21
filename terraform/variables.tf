variable "aws_region" {
  description = "The AWS region to deploy resources in."
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "project-name"
  type = string
  default = "wanderlust-mega-project"
}

variable "ec2_ami_id" {
  description = "ami-id for ec2 instances"
  type = string
  default = "ami-02d26659fd82cf299" 
}

variable "ec2_key_pair_name" {
  description = "Key pair name for EC2 instances."
  type        = string
  default     = "wanderlust-key"
}

variable "environment" {
  description = "The environment for resource tagging."
  type        = string
  default     = "development"
}


variable "ec2_instance_type" {
  description = "Type of EC2 instance."
  type        = string
  default     = "t2.micro"
}

variable "volume_size" {
  description = "Size of the root EBS volume in GB."
  type        = number
  default     = 20
  
}

variable "volume_type" {
  description = "type of volume"
  type       = string
  default    = "gp3"

}