output "vpc_id"{
  value = aws_vpc.challenge.id
}
output "public_subnet_1_id"{
  value = aws_subnet.public_subnet_1.id
}
output "public_subnet_2_id"{
  value = aws_subnet.public_subnet_2.id
}

output "instance1_public_ip"{
  value = aws_instance.instance1.public_ip
}

output "instance2_public_ip"{
  value = aws_instance.instance2.public_ip
}
