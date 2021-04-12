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