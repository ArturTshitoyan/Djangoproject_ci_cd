resource "aws_lb" "nlb" {
  name               = "Network-load-balancer"
  load_balancer_type = "network"
  subnets            = [aws_subnet.public-us-east-1a.id, aws_subnet.public-us-east-1b.id, aws_subnet.public-us-east-1c.id]
  enable_cross_zone_load_balancing = false
}

resource "aws_lb_target_group" "nlb_target_group" {
  port        = 30001
  protocol    = "TCP"
  target_type = "instance"
  vpc_id      = aws_vpc.main.id
  
  lifecycle {
    create_before_destroy = true
  }
   
  depends_on = [
    aws_lb.nlb
  ]
}

resource "aws_autoscaling_attachment" "attachment" {
  autoscaling_group_name = aws_eks_node_group.public-nodes.resources[0].autoscaling_groups[0].name
  lb_target_group_arn    = aws_lb_target_group.nlb_target_group.arn

  depends_on = [
    aws_lb_target_group.nlb_target_group
  ]
}

resource "aws_lb_listener" "nlb_listener" {
  load_balancer_arn = aws_lb.nlb.arn
  protocol          = "TCP"
  port              = 80

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nlb_target_group.arn
  }

  depends_on = [
    aws_lb.nlb
  ]
}