variable "auto_adjust_data" {
  type = object({
    auto_adjust_type      = string
    last_auto_adjust_time = optional(string)
    historical_options = optional(object({
      budget_adjustment_period   = number
      lookback_available_periods = optional(number)
    }))
  })
  default     = null
  description = "The parameters that determine the budget amount for an auto-adjusting budget."

  validation {
    condition     = var.auto_adjust_data == null || try(contains(["HISTORICAL", "FORECAST"], var.auto_adjust_data.auto_adjust_type), false)
    error_message = "auto_adjust_type must be either \"HISTORICAL\" or \"FORECAST\"."
  }

  validation {
    condition = var.auto_adjust_data == null || try(var.auto_adjust_data.historical_options == null, false) || try((
      var.auto_adjust_data.historical_options.budget_adjustment_period >= 1 &&
      var.auto_adjust_data.historical_options.budget_adjustment_period <= 60
    ), false)
    error_message = "if provided, budget_adjustment_period must be between 1 and 60."
  }
}

variable "billing_view_arn" {
  type        = string
  default     = null
  description = "The Amazon Resource Name (ARN) that uniquely identifies a specific billing view to use for the budget."
}

variable "budget_type" {
  type        = string
  default     = "COST"
  description = "Whether this budget tracks monetary cost or usage."

  validation {
    condition     = contains(["COST", "USAGE", "SAVINGS_PLANS_UTILIZATION", "RI_UTILIZATION"], var.budget_type)
    error_message = "Allowed values are \"COST\", \"USAGE\", \"SAVINGS_PLANS_UTILIZATION\" or \"RI_UTILIZATION\"."
  }
}

variable "cost_filter" {
  type        = map(any)
  default     = {}
  description = "Cost filters to apply to the budget"
}

variable "cost_types" {
  type = object({
    include_credit             = optional(bool, false)
    include_discount           = optional(bool, false)
    include_other_subscription = optional(bool, false)
    include_recurring          = optional(bool, false)
    include_refund             = optional(bool, false)
    include_subscription       = optional(bool, false)
    include_support            = optional(bool, false)
    include_tax                = optional(bool, false)
    include_upfront            = optional(bool, false)
    use_amortized              = optional(bool, true)
    use_blended                = optional(bool, false)
  })
  default     = {}
  description = "Cost types to apply to the budget"
}

variable "limit_amount" {
  type        = string
  default     = null
  description = "The amount of cost or usage being measured for a budget"

  validation {
    condition = (
      (var.limit_amount != null && var.auto_adjust_data == null && length(var.planned_limit) == 0) ||
      (var.limit_amount == null && var.auto_adjust_data != null && length(var.planned_limit) == 0) ||
      (var.limit_amount == null && var.auto_adjust_data == null && length(var.planned_limit) > 0)
    )
    error_message = "Exactly one of 'limit_amount', 'auto_adjust_data', or 'planned_limit' must be provided."
  }
}

variable "limit_unit" {
  type        = string
  default     = "USD"
  description = "The unit of measurement used for the budget forecast, actual spend, or budget threshold"
}

variable "name" {
  type        = string
  default     = null
  description = "Budget name. Either name or name_prefix must be provided, but not both"

  validation {
    condition     = (var.name != null && var.name_prefix == null) || (var.name == null && var.name_prefix != null)
    error_message = "Exactly one of 'name' or 'name_prefix' must be provided."
  }
}

variable "name_prefix" {
  type        = string
  default     = null
  description = "Budget name prefix. Either name or name_prefix must be provided, but not both"
}

variable "notifications" {
  type = list(object({
    comparison_operator        = optional(string, "GREATER_THAN")
    notification_type          = optional(string, "FORECASTED")
    subscriber_email_addresses = optional(list(string), [])
    subscriber_sns_topic_arns  = optional(list(string), [])
    threshold                  = optional(number, 100)
    threshold_type             = optional(string, "PERCENTAGE")
  }))
  default     = []
  description = "List of notifications for the budget. Each notification defines threshold, type, and subscribers."

  validation {
    condition = alltrue([
      for n in var.notifications : contains(["GREATER_THAN", "LESS_THAN", "EQUAL_TO"], n.comparison_operator)
    ])
    error_message = "comparison_operator must be one of: GREATER_THAN, LESS_THAN, EQUAL_TO."
  }

  validation {
    condition = alltrue([
      for n in var.notifications : contains(["PERCENTAGE", "ABSOLUTE_VALUE"], n.threshold_type)
    ])
    error_message = "threshold_type must be either PERCENTAGE or ABSOLUTE_VALUE."
  }

  validation {
    condition = alltrue([
      for n in var.notifications : contains(["ACTUAL", "FORECASTED"], n.notification_type)
    ])
    error_message = "notification_type must be either ACTUAL or FORECASTED."
  }

  validation {
    condition = alltrue([
      for n in var.notifications : length(n.subscriber_email_addresses) > 0 || length(n.subscriber_sns_topic_arns) > 0
    ])
    error_message = "Each notification must have at least one subscriber (email or SNS topic)."
  }
}

variable "planned_limit" {
  type = list(object({
    amount     = number
    start_time = string
    unit       = string
  }))
  default     = []
  description = "A list of planned budget limits. Each limit defines a budget amount, start time, and optional unit."
}

variable "time_period_end" {
  type        = string
  default     = null
  description = "The end of the time period covered by the budget. There are no restrictions on the end date. `Format: 2017-01-01_12:00`."
}

variable "time_period_start" {
  type        = string
  default     = null
  description = "The start of the time period covered by the budget. If not provided, defaults to the current date. `Format: 2017-01-01_12:00`."
}

variable "time_unit" {
  type        = string
  default     = "MONTHLY"
  description = "The length of time until a budget resets the actual and forecasted spend"

  validation {
    condition     = contains(["DAILY", "MONTHLY", "QUARTERLY", "ANNUALLY"], var.time_unit)
    error_message = "Allowed values are \"DAILY\", \"MONTHLY\", \"QUARTERLY\" or \"ANNUALLY\"."
  }
}
