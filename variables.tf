
################# Prefix and Suffix ##################
variable "prefix" {
  description = "Use on all provisioned resources"
  type        = string
  default     = null
}

variable "suffix" {
  description = "Use on all provisioned resources"
  type        = string
  default     = null
}

################# Region ##################
variable "region" {
  description = "region"
  type        = string
  default     = null
}


################# Network ##################
variable "create_network" {
  description = "Create VPC and Other network components"
  type        = bool
  default     = null
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "availability_zones" {
  type    = list(string)
  default = []
}

variable "private_subnet_cidr_block" {
  type = list(string)
}

variable "public_subnet_cidr_block" {
  type = list(string)
}

variable "db_subnet_cidr_block" {
  type = list(string)
}

variable "create_db_security_group" {
  type    = bool
  default = true
}


################# EC2 instance ##################
variable "create_gitlab_server" {
  description = "Create Ec2 for gitlab"
  type        = bool
  default     = null
}

variable "instance_type" {
  type    = string
  default = null
}

variable "ebs_volume_size" {
  type    = string
  default = null
}

################# RDS instance ##################

variable "create_postgres_db" {
  type    = bool
  default = null
}

variable "db_instance_type" {
  type    = string
  default = null
}

variable "db_storage_size" {
  type    = number
  default = null
}

variable "max_db_storage_size" {
  type    = number
  default = null
}

variable "db_master_username" {
  type    = string
  default = null
}

variable "db_port" {
  type    = number
  default = null
}

variable "db_password" {
  description = "Name of the AWS SSM Parameter Store parameter containing the RDS password"
  type        = string
  default     = "/devops/gitlab/rds/password/dontdelete"
}

