data "template_file" "user_data" {
  template = <<EOF
#!/bin/bash

cd /etc/systemd/system/
echo HOST_NAME=${aws_db_instance.postgres_database.address} >> service.env
echo DB_PORT=${var.db_port} >> service.env
echo API_PORT=${var.application_port} >> service.env
echo DB_NAME=${var.db_name} >> service.env
echo DB_USERNAME=${var.db_master_username} >> service.env
echo DB_PASSWORD=${var.db_master_password} >> service.env
echo AWS_S3_BUCKET_NAME=${aws_s3_bucket.s3_bucket.bucket} >> service.env
echo AWS_BUCKET_REGION=${var.region} >> service.env

systemctl daemon-reload
systemctl enable userWebApp.service
systemctl start userWebApp.service

EOF
}

resource "aws_launch_template" "lt" {
  depends_on              = [aws_db_instance.postgres_database]
  name                    = var.launch_template_name
  description             = var.launch_template_description
  image_id                = var.custom_ami_id
  instance_type           = var.instance_type
  disable_api_termination = var.disable_api_termination

  block_device_mappings {
    device_name = var.device_name
    ebs {
      volume_size           = var.aws_instance_vol_size
      volume_type           = var.aws_instance_vol_type
      delete_on_termination = var.delete_on_termination
    }
  }

  user_data = base64encode(data.template_file.user_data.rendered)

  network_interfaces {
    associate_public_ip_address = var.associate_public_ip
    security_groups             = [aws_security_group.application-sg.id]
  }

  key_name = aws_key_pair.ec2_access.key_name

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_profile.name
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg_launch_config" {
  depends_on       = [aws_launch_template.lt, aws_db_instance.postgres_database, aws_lb_target_group.target_group_load_balancer]
  name             = var.asg_name
  max_size         = var.asg_max
  min_size         = var.asg_min
  default_cooldown = var.asg_cooldown
  desired_capacity = var.asg_desired_capacity

  launch_template {
    id      = aws_launch_template.lt.id
    version = aws_launch_template.lt.latest_version
  }

  vpc_zone_identifier = [element(tolist(data.aws_subnet_ids.subnetIDs.ids), 0), element(tolist(data.aws_subnet_ids.subnetIDs.ids), 1),
  element(tolist(data.aws_subnet_ids.subnetIDs.ids), 2)]

  target_group_arns = [aws_lb_target_group.target_group_load_balancer.arn]

  tag {
    key                 = var.asg_tag_key
    propagate_at_launch = var.asg_propagate_at_launch
    value               = var.asg_tag_value
  }
}

resource "aws_autoscaling_policy" "scale_out_policy" {
  autoscaling_group_name = aws_autoscaling_group.asg_launch_config.name
  name                   = var.autoscaling_policy_name_scale_out
  scaling_adjustment     = var.scaling_adjustment_scale_out
  adjustment_type        = var.adjustment_type
  cooldown               = var.auto_scaling_policy_cooldown
}

resource "aws_autoscaling_policy" "scale_in_policy" {
  autoscaling_group_name = aws_autoscaling_group.asg_launch_config.name
  name                   = var.autoscaling_policy_name_scale_in
  scaling_adjustment     = var.scaling_adjustment_scale_in
  adjustment_type        = var.adjustment_type
  cooldown               = var.auto_scaling_policy_cooldown
}

resource "aws_cloudwatch_metric_alarm" "scale_out_alarm" {
  alarm_name          = var.metric_alarm_name_so
  comparison_operator = var.metric_alarm_comparision_operator_so
  evaluation_periods  = var.metric_alarm_evaluation_periods
  metric_name         = var.metric_name
  namespace           = var.metric_alarm_namespace
  period              = var.metric_alarm_period
  statistic           = var.metric_alarm_statistic
  threshold           = var.metric_alarm_threshold_so

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.asg_launch_config.name
  }

  alarm_description = var.metric_alarm_description_so
  alarm_actions     = [aws_autoscaling_policy.scale_out_policy.arn]
}

resource "aws_cloudwatch_metric_alarm" "scale_in_alarm" {
  alarm_name          = var.metric_alarm_name_si
  comparison_operator = var.metric_alarm_comparision_operator_si
  evaluation_periods  = var.metric_alarm_evaluation_periods
  metric_name         = var.metric_name
  namespace           = var.metric_alarm_namespace
  period              = var.metric_alarm_period
  statistic           = var.metric_alarm_statistic
  threshold           = var.metric_alarm_threshold_si

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.asg_launch_config.name
  }

  alarm_description = var.metric_alarm_description_si
  alarm_actions     = [aws_autoscaling_policy.scale_in_policy.arn]
}