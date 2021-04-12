resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.challenge.id

  tags = {
    Name = "${local.project_name}-igw"
  }
}