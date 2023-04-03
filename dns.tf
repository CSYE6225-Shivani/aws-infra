data "aws_route53_zone" "zone_details" {
  name         = "${var.profile}.${var.domain_name}"
  private_zone = var.route53_private_zone
}

resource "aws_route53_record" "a_record" {
  depends_on = [aws_lb.lb, data.aws_route53_zone.zone_details]
  name       = data.aws_route53_zone.zone_details.name
  type       = var.route53_record_type

  alias {
    evaluate_target_health = true
    name                   = aws_lb.lb.dns_name
    zone_id                = aws_lb.lb.zone_id
  }

  zone_id = data.aws_route53_zone.zone_details.zone_id
  //Commenting this part for Assignment 08 - Start
  #  records    = [aws_instance.application-ec2.public_ip]
  #  ttl        = var.ttl_value
  //Commenting this part for Assignment 08 - End
}

