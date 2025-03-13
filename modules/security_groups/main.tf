resource "aws_security_group" "allow_tls" {
  name        = "ronnie_alb_security_group"
  description = "Allows inbound traffic to the ALB security group"
  vpc_id      = var.vpc_id

  tags = {
    Name = "ronnie_alb_security_group"
  }
}