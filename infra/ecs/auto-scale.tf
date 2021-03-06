
resource "aws_appautoscaling_target" "app_scale_target" {
  service_namespace  = "ecs"
  resource_id        = "service/${aws_ecs_cluster.cluster.name}/${aws_ecs_service.web-api.name}"
  scalable_dimension = "ecs:service:DesiredCount"

  max_capacity = var.max_tasks
  min_capacity = var.min_tasks
}

resource "aws_cloudwatch_metric_alarm" "cpu_utilization_high" {
  alarm_name          = "${var.cluster_name}-CPU-Utilization-High"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Maximum"
  threshold           = var.cpu_to_scale_up

  dimensions = {
    ClusterName = aws_ecs_cluster.cluster.name
    ServiceName = aws_ecs_service.web-api.name
  }

  alarm_actions = [aws_appautoscaling_policy.app_up.arn]
}

resource "aws_appautoscaling_policy" "app_up" {
  name               = "${var.cluster_name}-app-scale-up"
  service_namespace  = aws_appautoscaling_target.app_scale_target.service_namespace
  resource_id        = aws_appautoscaling_target.app_scale_target.resource_id
  scalable_dimension = aws_appautoscaling_target.app_scale_target.scalable_dimension

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Maximum"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = 1
    }
  }
}

resource "aws_cloudwatch_metric_alarm" "cpu_utilization_low" {
  alarm_name          = "${var.cluster_name}-CPU-Utilization-Low"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = var.cpu_to_scale_down

  dimensions = {
    ClusterName = aws_ecs_cluster.cluster.name
    ServiceName = aws_ecs_service.web-api.name
  }

  alarm_actions = [aws_appautoscaling_policy.app_down.arn]
}

resource "aws_appautoscaling_policy" "app_down" {
  name               = "${var.cluster_name}-scale-down"
  service_namespace  = aws_appautoscaling_target.app_scale_target.service_namespace
  resource_id        = aws_appautoscaling_target.app_scale_target.resource_id
  scalable_dimension = aws_appautoscaling_target.app_scale_target.scalable_dimension

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 300
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = -1
    }
  }
}


resource "aws_appautoscaling_target" "worker_consumer_scale_target" {
  service_namespace  = "ecs"
  resource_id        = "service/${aws_ecs_cluster.cluster.name}/${aws_ecs_service.worker-consumer.name}"
  scalable_dimension = "ecs:service:DesiredCount"

  max_capacity = var.worker_consumer_max_tasks
  min_capacity = var.worker_consumer_min_tasks
}

resource "aws_cloudwatch_metric_alarm" "worker_consumer_cpu_utilization_high" {
  alarm_name          = "${var.worker_consumer_name}-CPU-Utilization-High"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Maximum"
  threshold           = var.worker_consumer_cpu_to_scale_up

  dimensions = {
    ClusterName = aws_ecs_cluster.cluster.name
    ServiceName = aws_ecs_service.worker-consumer.name
  }

  alarm_actions = [aws_appautoscaling_policy.worker_consumer_up.arn]
}

resource "aws_appautoscaling_policy" "worker_consumer_up" {
  name               = "${var.worker_consumer_name}-app-scale-up"
  service_namespace  = aws_appautoscaling_target.worker_consumer_scale_target.service_namespace
  resource_id        = aws_appautoscaling_target.worker_consumer_scale_target.resource_id
  scalable_dimension = aws_appautoscaling_target.worker_consumer_scale_target.scalable_dimension

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Maximum"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = 1
    }
  }
}

resource "aws_cloudwatch_metric_alarm" "worker_consumer_cpu_utilization_low" {
  alarm_name          = "${var.worker_consumer_name}-CPU-Utilization-Low"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = var.worker_consumer_cpu_to_scale_down

  dimensions = {
    ClusterName = aws_ecs_cluster.cluster.name
    ServiceName = aws_ecs_service.worker-consumer.name
  }

  alarm_actions = [aws_appautoscaling_policy.worker_consumer_down.arn]
}

resource "aws_appautoscaling_policy" "worker_consumer_down" {
  name               = "${var.worker_consumer_name}-scale-down"
  service_namespace  = aws_appautoscaling_target.worker_consumer_scale_target.service_namespace
  resource_id        = aws_appautoscaling_target.worker_consumer_scale_target.resource_id
  scalable_dimension = aws_appautoscaling_target.worker_consumer_scale_target.scalable_dimension

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 300
    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = -1
    }
  }
}