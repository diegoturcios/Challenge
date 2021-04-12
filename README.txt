========== DevOps Challenge ==========

Primero, nunca habia trabajado con terraform o Ansible y para configurar todo en Terraform utilice la documentacion que brinda Terraform para AWS así que les dejo el link:
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elb
Honestamente no se si esto lo consideran plagio, pero si es plagio de verdad mil disculpas.Mis conocimientos son bien basicos y estoy aplicando por lo mismo porque quiero aprender.


=============================================================

PASO 1: 
Crear una VPC y dos subredes publicas en dos zonas diferentes.

#############################################
##PROVIDER_AWS - definir AWS como proveedor##
#############################################

provider "aws" {
  region     = "us-east-1"
  access_key = "AKIATZWRZK24NTKJF4GV"
  secret_key = "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"
}

#########################################################
##LOCALS – definir el nombre del proyecto para los tags##
#########################################################

locals { 
  project_name = "challenge"
}

#######################
##VPC – crear la vpc##
#######################

resource "aws_vpc" "challenge" {
  cidr_block       = "10.0.0.0/16"
  enable_dns_hostnames = "true"

  tags = {
    Name = "${local.project_name}-vpc"
  }
}

############################################################################
##PUBLIC_SUBNETS – crear las dos subredes publicas en dos zonas diferentes##
##Tome como zona principal US-EAST-1#
############################################################################

resource "aws_subnet" "public_subnet_1" {
  vpc_id     = aws_vpc.challenge.id
  cidr_block = "10.0.10.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${local.project_name}-public_subnet_1"
  }
}


resource "aws_subnet" "public_subnet_2" {
  vpc_id     = aws_vpc.challenge.id
  cidr_block = "10.0.11.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "${local.project_name}-public_subnet_2"
  }
}

#############################
###IGW – definir el Gateway##
#############################

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.challenge.id

  tags = {
    Name = "${local.project_name}-igw"
  }
}

#########################################
##ROUTE_TABLE – crear la tabla de rutas##
#########################################

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.challenge.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${local.project_name}-public-rt"
  }
}

resource "aws_route_table_association" "public_subnet_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_subnet_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_rt.id
}


###########################################################
##NETWORK_ACL – control de trafico dentro de las subredes##
###########################################################

resource "aws_network_acl" "acl" {
  vpc_id = aws_vpc.challenge.id
  subnet_ids = [
  aws_subnet.public_subnet_1.id,
  aws_subnet.public_subnet_2.id,
  ]


  tags = {
    Name = "${local.project_name}-acl"
  }
}


resource "aws_network_acl_rule" "ingress_100" {
  network_acl_id = aws_network_acl.acl.id
  rule_number    = 100
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 22
  to_port        = 22
}

resource "aws_network_acl_rule" "ingress_101" {
  network_acl_id = aws_network_acl.acl.id
  rule_number    = 101
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 1024
  to_port        = 65535
}

resource "aws_network_acl_rule" "ingress_102" {
  network_acl_id = aws_network_acl.acl.id
  rule_number    = 102
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 80
  to_port        = 80
}

resource "aws_network_acl_rule" "ingress_103" {
  network_acl_id = aws_network_acl.acl.id
  rule_number    = 103
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
}

resource "aws_network_acl_rule" "ingress_104" {
  network_acl_id = aws_network_acl.acl.id
  rule_number    = 104
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 8888
  to_port        = 8888
}


resource "aws_network_acl_rule" "egress_100" {
  network_acl_id = aws_network_acl.acl.id
  rule_number    = 100
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 1024
  to_port        = 65535
}

resource "aws_network_acl_rule" "egress_101" {
  network_acl_id = aws_network_acl.acl.id
  rule_number    = 101
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 80
  to_port        = 80
}

resource "aws_network_acl_rule" "egress_102" {
  network_acl_id = aws_network_acl.acl.id
  rule_number    = 102
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
}

=======================================================

PASO 2: Crear dos instancias EC2 y asignarlas a la VPC.

##################################################################
##INSTANCES – crear dos instancias y asignar una a cada subred####
##La ami que estoy usando para ambas es para Windows Server 2019##
##################################################################

resource "aws_instance" "instance1" {
  ami           = "ami-07817f5d0e3866d32"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public_subnet_1.id
  vpc_security_group_ids = [ aws_security_group.allow_instance1.id ]

  tags = {
    Name = "instance1"
  }
}

resource "aws_instance" "instance2" {
  ami           = "ami-07817f5d0e3866d32"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public_subnet_2.id
  vpc_security_group_ids = [ aws_security_group.allow_instance2.id ]

  tags = {
    Name = "instance2"
  }
}

======================================================================

PASO 3: Crear una aplicación de balance de carga

######################################################################
##LOAD_BALANCER – crear un balanceador de carga para las instanncias##
######################################################################

resource "aws_elb" "elb" {
 name = "elb"
 security_groups = [aws_security_group.allow_lb.id]
 availability_zones = ["us-east-1a", "us-east-1b"]

listener {
  instance_port = 80
  instance_protocol = "http"
  lb_port = 80
  lb_protocol = "http"
}

health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8000/"
    interval            = 30
  }

  instances                   = [aws_instance.instance1.id]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

 tags = {
   Name = "${local.project_name}-elb"
 }
}

###########################################################
##SECURITY_GROUP – control de tráfico para las instancias##
###########################################################

resource "aws_security_group" "allow_instance1" {
  name        = "allow_instance1"
  description = "Allow instance1 inbound traffic"
  vpc_id      = aws_vpc.challenge.id

  ingress {
    description = "allow instance1"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow instance1"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
  egress {
    description = "allow all"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "allow_instance2" {
  name        = "allow_instance2"
  description = "Allow instance2 inbound traffic"
  vpc_id      = aws_vpc.challenge.id

  ingress {
    description = "allow instance2"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow instance2"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
  egress {
    description = "allow all"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "allow_lb" {
  name        = "allow_lb"
  description = "Allow lb inbound traffic"
  vpc_id      = aws_vpc.challenge.id

  ingress {
    description = "allow lb"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "allow all"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

=======================================================================

Paso 4: Instalar la app y configurarla


No tengo paso 4, no pude hacerlo y no porque no quisiera.


========================================================================
