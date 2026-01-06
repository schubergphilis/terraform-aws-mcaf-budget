resource "aws_budgets_budget" "default" {
  name              = var.name != null ? "budget-${var.name}-${lower(var.time_unit)}" : null
  name_prefix       = var.name_prefix
  billing_view_arn  = var.billing_view_arn
  budget_type       = var.budget_type
  limit_amount      = var.limit_amount
  limit_unit        = var.limit_unit
  time_period_end   = var.time_period_end
  time_period_start = var.time_period_start != null ? var.time_period_start : "${substr(timestamp(), 0, 10)}_00:00"
  time_unit         = var.time_unit

  dynamic "auto_adjust_data" {
    for_each = var.auto_adjust_data != null ? [var.auto_adjust_data] : []

    content {
      auto_adjust_type      = auto_adjust_data.value.auto_adjust_type
      last_auto_adjust_time = auto_adjust_data.value.last_auto_adjust_time

      dynamic "historical_options" {
        for_each = auto_adjust_data.value.historical_options != null ? [auto_adjust_data.value.historical_options] : []

        content {
          budget_adjustment_period   = historical_options.value.budget_adjustment_period
          lookback_available_periods = historical_options.value.lookback_available_periods
        }
      }
    }
  }

  dynamic "cost_filter" {
    for_each = var.cost_filter

    content {
      name   = cost_filter.key
      values = cost_filter.value
    }
  }

  cost_types {
    include_credit             = var.cost_types.include_credit
    include_discount           = var.cost_types.include_discount
    include_other_subscription = var.cost_types.include_other_subscription
    include_recurring          = var.cost_types.include_recurring
    include_refund             = var.cost_types.include_refund
    include_subscription       = var.cost_types.include_subscription
    include_support            = var.cost_types.include_support
    include_tax                = var.cost_types.include_tax
    include_upfront            = var.cost_types.include_upfront
    use_amortized              = var.cost_types.use_amortized
    use_blended                = var.cost_types.use_blended
  }

  dynamic "notification" {
    for_each = var.notifications

    content {
      comparison_operator        = notification.value.comparison_operator
      notification_type          = notification.value.notification_type
      subscriber_email_addresses = notification.value.subscriber_email_addresses
      subscriber_sns_topic_arns  = notification.value.subscriber_sns_topic_arns
      threshold                  = notification.value.threshold
      threshold_type             = notification.value.threshold_type
    }
  }

  dynamic "planned_limit" {
    for_each = var.planned_limit

    content {
      amount     = planned_limit.value.amount
      start_time = planned_limit.value.start_time
      unit       = planned_limit.value.unit
    }
  }

  lifecycle {
    ignore_changes = [time_period_start]
  }
}
