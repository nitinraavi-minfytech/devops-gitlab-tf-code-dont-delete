module "ec2_instance" {
  create                      = var.create_gitlab_server
  source                      = "terraform-aws-modules/ec2-instance/aws"
  ami                         = local.ami_id
  instance_type               = var.instance_type
  associate_public_ip_address = true
  vpc_security_group_ids      = [module.vpc.default_security_group_id]
  subnet_id                   = module.vpc.public_subnets[0]
  create_iam_instance_profile = true
  iam_role_name               = "${var.prefix}-iam-role-${var.suffix}"
  iam_role_description        = "${var.prefix}-iam-role-${var.suffix}"
  iam_role_policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
  }
  root_block_device = [
    {
      encrypted   = true
      volume_type = "gp3"
      throughput  = 125
      iops        = 3000
      volume_size = var.ebs_volume_size
      volume_tags = {
        Name = "${var.prefix}-server-volume-${var.suffix}"
      }
    },
  ]
  # user_data = file("${path.module}/user_data.sh")
  user_data = <<-EOF
              #!/bin/bash
              sudo apt update
              sudo apt upgrade -y
              echo "export DB_PASSWORD=${data.aws_ssm_parameter.db_password.value}" >> /etc/profile
              EOF
  tags = {
    Name = "${var.prefix}-server-${var.suffix}"
  }
}
