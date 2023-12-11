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
  })
  default = {
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
  description = "Cost types to apply to the budget"
}

variable "limit_amount" {
  type        = string
  description = "The amount of cost or usage being measured for a budget"
}

variable "limit_unit" {
  type        = string
  default     = "USD"
  description = "The unit of measurement used for the budget forecast, actual spend, or budget threshold"
}

variable "name" {
  type        = string
  description = "Budget name"
}

variable "notification_threshold" {
  type        = number
  default     = 100
  description = "% threshold when the notification should be sent"
}

variable "subscriber_email_addresses" {
  type        = list(string)
  description = "E-mail addresses to notify when the threshold is met"
}

variable "time_unit" {
  type        = string
  default     = "MONTHLY"
  description = "The length of time until a budget resets the actual and forecasted spend"

  validation {
    condition     = contains(["MONTHLY", "QUARTERLY", "ANNUALLY"], var.time_unit)
    error_message = "Allowed values are \"MONTHLY\", \"QUARTERLY\" or \"ANNUALLY\"."
  }
}
