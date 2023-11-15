resource "aws_budgets_budget" "default" {
  name              = "budget-${var.name}-${lower(var.time_unit)}"
  budget_type       = "COST"
  limit_amount      = var.limit_amount
  limit_unit        = "USD"
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
    include_credit             = false
    include_discount           = false
    include_other_subscription = false
    include_recurring          = false
    include_refund             = false
    include_subscription       = false
    include_support            = false
    include_tax                = false
    include_upfront            = false
    use_amortized              = true
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
