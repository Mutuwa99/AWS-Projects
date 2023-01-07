resource "aws_lb_target_group" "Noblemulaudzi" {
  name     = "application-front"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.Noble_vpc.id
  health_check {
    enabled = true
    healthy_threshold = 3
    interval = 10
    matcher = 200
    path = "/"
    port = "traffic-port"
    protocol = "HTTP"
    timeout = 3
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group_attachment" "attach-app1" {
  target_group_arn = aws_lb_target_group.Noblemulaudzi.arn
  target_id        = aws_instance.server_one.id
  port             = 80
}
resource "aws_lb_target_group_attachment" "attach-app2" {
  target_group_arn = aws_lb_target_group.Noblemulaudzi.arn
  target_id        = aws_instance.server_two.id
  port             = 80
}
resource "aws_lb_target_group_attachment" "attach-app3" {
  target_group_arn = aws_lb_target_group.Noblemulaudzi.arn
  target_id        = aws_instance.server_three.id
  port             = 80
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.Noblemulaudzi.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.Noblemulaudzi.arn
  }
}

resource "aws_lb" "Noblemulaudzi" {
  name               = "Noblemulaudzi"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.mysg.id]
  subnets            = [aws_subnet.my_first_subnet.id, aws_subnet.my_second_subnet.id, aws_subnet.my_third_subnet.id]

  enable_deletion_protection = true

  tags = {
    Environment = "Noblemulaudzi"
  }
}