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