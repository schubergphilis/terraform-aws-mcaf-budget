variable "cost_filter" {
  type        = map(any)
  default     = {}
  description = "Cost filters to apply to the budget"
}

variable "limit_amount" {
  type        = string
  description = "The amount of cost or usage being measured for a budget"
}

variable "name" {
  type        = string
  description = "Budget name"
}

variable "notification_threshold" {
  type        = string
  default     = 100
  description = "% Threshold when the notification should be sent"
}

variable "subscriber_email_addresses" {
  type        = list(string)
  description = "E-mail addresses to notify when the threshold is met"
}

variable "time_unit" {
  type        = string
  description = "The length of time until a budget resets the actual and forecasted spend. Valid values: MONTHLY, QUARTERLY, ANNUALLY"
  default     = "MONTHLY"
}
