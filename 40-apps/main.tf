module "mysql" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  ami = local.ami 
  name = "${local.resource_name}-mysql"

  instance_type          = "t2.micro"
  vpc_security_group_ids = [local.mysql_sg_id]
  subnet_id              = local.database_subnet_id

  tags = merge (
    var.common_tags,
    var.mysql_tags,
  {
    Name = "${local.resource_name}-mysql"
  }
)
}

module "backend" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  ami = local.ami 
  name = "${local.resource_name}-backend"

  instance_type          = "t2.micro"
  vpc_security_group_ids = [local.backend_sg_id]
  subnet_id              = local.private_subnet_id

  tags = merge (
    var.common_tags,
    var.backend_tags,
  {
    Name = "${local.resource_name}-backend"
  }
)
}

module "frontend" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  ami = local.ami 
  name = "${local.resource_name}-frontend"

  instance_type          = "t2.micro"
  vpc_security_group_ids = [local.frontend_sg_id]
  subnet_id              = local.public_subnet_id

  tags = merge (
    var.common_tags,
    var.frontend_tags,
  {
    Name = "${local.resource_name}-frontend"
  }
)
}