data "aws_route53_zone" "zone_details" {
  name         = "${var.profile}.${var.domain_name}"
  private_zone = var.route53_private_zone
}

resource "aws_route53_record" "a_record" {
  depends_on = [aws_instance.application-ec2, data.aws_route53_zone.zone_details]
  name       = data.aws_route53_zone.zone_details.name
  type       = var.route53_record_type
  zone_id    = data.aws_route53_zone.zone_details.zone_id
  records    = [aws_instance.application-ec2.public_ip]
  ttl        = var.ttl_value
}

