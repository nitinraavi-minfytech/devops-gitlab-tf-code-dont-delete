module "vpc" {
  create_vpc                  = var.create_network
  source                      = "terraform-aws-modules/vpc/aws"
  cidr                        = var.vpc_cidr
  azs                         = var.availability_zones
  private_subnets             = var.private_subnet_cidr_block
  public_subnets              = var.public_subnet_cidr_block
  enable_nat_gateway          = false
  enable_vpn_gateway          = false
  database_subnet_group_name  = "${var.prefix}-db_subnet_group-${var.suffix}"
  database_subnets            = var.db_subnet_cidr_block
  default_security_group_name = "${var.prefix}-sg-${var.suffix}"

  default_security_group_ingress = [
    {
      description = "Allow inbound HTTP traffic"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      description = "Allow inbound HTTPS traffic"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      description = "Allow inbound SSH traffic"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
  default_security_group_egress = [
    {
      description = "Allow all outbound traffic"
      from_port   = 0
      to_port     = 0
      protocol    = "-1" # Indicates all protocols
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  vpc_tags = {
    Name = "${var.prefix}-vpc-${var.suffix}"
  }

  public_subnet_tags = {
    Name = "${var.prefix}-public-subnet-${var.suffix}"
  }

  private_subnet_tags = {
    Name = "${var.prefix}-private-subnet-${var.suffix}"
  }

  igw_tags = {
    Name = "${var.prefix}-ig-${var.suffix}"
  }

  database_subnet_tags = {
    Name = "${var.prefix}-db-subnet-${var.suffix}"
  }

  private_route_table_tags = {
    Name = "${var.prefix}-private-rt-${var.suffix}"
  }

  public_route_table_tags = {
    Name = "${var.prefix}-public-rt-${var.suffix}"
  }

  default_security_group_tags = {
    Name = "${var.prefix}-security-group-${var.suffix}"
  }

  dhcp_options_tags = {
    Name = "${var.prefix}-dhcp-${var.suffix}"
  }

  default_network_acl_tags = {
    Name = "${var.prefix}-nw-acl-${var.suffix}"
  }
}


module "db_security_group" {
  create      = var.create_db_security_group
  source      = "terraform-aws-modules/security-group/aws"
  name        = "${var.prefix}-db-sg-${var.suffix}"
  description = "Security_group for PostgreSQL traffic"
  vpc_id      = module.vpc.vpc_id
  ingress_with_cidr_blocks = [
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      description = "Allow inbound PostgreSQL traffic"
      cidr_blocks = "10.10.0.0/16"
    },
    {
      rule        = "postgresql-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}