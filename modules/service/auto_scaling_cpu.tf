resource "aws_appautoscaling_target" "app_scale_target" {
    service_namespace  = "ecs"
    resource_id        =format("service/%s/%s", var.cluster_name, var.service_name)
    scalable_dimension = "ecs:service:DesiredCount"
    max_capacity       = var.max_tasks
    min_capacity       = var.min_tasks

    depends_on = [aws_ecs_service.service]
}

// Trocar aqui
resource "aws_cloudwatch_metric_alarm" "cpu_utilization_high" {
  alarm_name          = format("%s-%s-cpu-high", var.cluster_name, var.service_name)
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.cpu_evaluation_periods
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  statistic           = "Average"
  period              = var.cpu_verification_period
  threshold           = var.cpu_to_scale_up

  dimensions = {
    ClusterName = var.cluster_name
    ServiceName = var.service_name
  }

  alarm_actions = [aws_appautoscaling_policy.app_up.arn]
}

resource "aws_appautoscaling_policy" "app_up" {
  name               = format("%s-%s-cpu-scale-up", var.cluster_name, var.service_name)
  service_namespace  = aws_appautoscaling_target.app_scale_target.service_namespace
  resource_id        = aws_appautoscaling_target.app_scale_target.resource_id
  scalable_dimension = aws_appautoscaling_target.app_scale_target.scalable_dimension

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = var.cpu_verification_period
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = 1
    }
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu_utilization_low" {
  alarm_name          = format("%s-%s-cpu-low", var.cluster_name, var.service_name)
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = var.cpu_verification_period
  statistic           = "Average"
  threshold           = var.cpu_to_scale_down

  dimensions = {
    ClusterName = var.cluster_name
    ServiceName = var.service_name
  }

  alarm_actions = [aws_appautoscaling_policy.app_down.arn]
}


resource "aws_appautoscaling_policy" "app_down" {
  name               = format("%s-%s-cpu-scale-down", var.cluster_name, var.service_name)
  service_namespace  = aws_appautoscaling_target.app_scale_target.service_namespace
  resource_id        = aws_appautoscaling_target.app_scale_target.resource_id
  scalable_dimension = aws_appautoscaling_target.app_scale_target.scalable_dimension

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = var.cpu_verification_period
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = -1
    }
  }
}