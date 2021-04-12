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