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