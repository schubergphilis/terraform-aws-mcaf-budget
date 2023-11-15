resource "aws_budgets_budget" "default" {
  name              = "budget-${var.name}-${lower(var.time_unit)}"
  budget_type       = "COST"
  limit_amount      = var.limit_amount
  limit_unit        = var.limit_unit
  time_period_start = "${substr(timestamp(), 0, 10)}_00:00"
  time_unit         = var.time_unit

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
  }

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = var.notification_threshold
    threshold_type             = "PERCENTAGE"
    notification_type          = "FORECASTED"
    subscriber_email_addresses = var.subscriber_email_addresses
  }

  lifecycle {
    ignore_changes = [time_period_start]
  }
}
