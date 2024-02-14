################# Prefix and Suffix ##################
prefix = "devops-gitlab"
suffix = "donot-delete"

################# Region ##################
region = "us-east-1"

################# Network ##################
create_network            = true
availability_zones        = ["us-east-1a", "us-east-1b"]
vpc_cidr                  = "10.0.0.0/16"
public_subnet_cidr_block  = ["10.0.0.0/24", "10.0.1.0/24"]
private_subnet_cidr_block = ["10.0.2.0/24", "10.0.3.0/24"]
db_subnet_cidr_block      = ["10.0.4.0/24", "10.0.5.0/24"]
create_db_security_group  = true


################# EC2 GitLab Server ##################
create_gitlab_server = true
instance_type        = "c6g.large"
ebs_volume_size      = "100"

################# RDS ##################
create_postgres_db  = true
db_instance_type    = "db.t4g.micro"
db_storage_size     = 10
max_db_storage_size = 20
db_port             = 5432
db_master_username  = "Administrator"

