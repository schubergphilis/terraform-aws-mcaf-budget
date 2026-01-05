# terraform-aws-mcaf-budget

Terraform module to create and manage an AWS Budget.

## Budget Types

This module supports three mutually exclusive budget configuration options. You must specify exactly one:

### 1️⃣ Enforcement Budget – `var.limit_amount`

"Do not exceed this"

Use this for simple, fixed-amount budgets that set a hard spending threshold. This is the most common and straightforward budget type.

- Single fixed amount for the entire time period
- Simple to configure and understand
- Best for cost control and alerts

**Example use case:** A workload with a fixed monthly cloud budget of $50,000.

### 2️⃣ Planned Budget – `var.planned_limit`

"What we intend to spend"

Use this for budgets with predetermined spending limits that vary over time. Perfect for projects with phased spending plans or seasonal workload patterns.

- Allows you to define multiple budget periods with different amounts
- Each period has a specific start time and amount
- Ideal for forecasting and planning scenarios

**Example use case:** A project that expects $10,000 spend in Q1, $15,000 in Q2, and $20,000 in Q3-Q4.

### 3️⃣ Auto-Adjusting Budget – `var.auto_adjust_data`

"What AWS expects we'll spend"

Use this for budgets that automatically adjust based on your historical or forecasted spending patterns. AWS analyzes your spending trends and sets the budget accordingly.

- Dynamically adjusts based on historical spend or AWS forecasts
- Useful for stable, predictable workloads
- Reduces manual budget maintenance

**Example use case:** Production environments with steady, predictable usage that grows gradually over time.

> [!IMPORTANT]
> Please note a limitation in AWS Budgets in comparison to Cost Explorer: AWS Budgets does not currently fully align with Cost Explorer, lacking support for charge types related to Savings Plans or reservation-applied usage. Consequently, the expenditure displayed in AWS Budgets may differ from what you observe in AWS Cost Explorer or your AWS bill.

As a temporary workaround, you should choose the following charge types in Cost Explorer after clicking "View in Cost Explorer" in your AWS Budget:

- Usage (should already be selected)
- Reservation applied usage
- Savings Plan Covered Usage
- Savings Plan Negation
- Savings Plan Recurring Fee
- Savings Plan Upfront Fee

Now the Budgets/Cost Explorer values be the same. AWS expects Cloud Explorer parity to be complete by EOY 2024.

> [!TIP]
> We do not pin modules to versions in our examples. We highly recommend that in your code you pin the version to the exact version you are using so that your infrastructure remains stable.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.13.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6.13.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_budgets_budget.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/budgets_budget) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_adjust_data"></a> [auto\_adjust\_data](#input\_auto\_adjust\_data) | The parameters that determine the budget amount for an auto-adjusting budget. | <pre>object({<br/>    auto_adjust_type      = string<br/>    last_auto_adjust_time = optional(string)<br/>    historical_options = optional(object({<br/>      budget_adjustment_period   = number<br/>      lookback_available_periods = optional(number)<br/>    }))<br/>  })</pre> | `null` | no |
| <a name="input_billing_view_arn"></a> [billing\_view\_arn](#input\_billing\_view\_arn) | The Amazon Resource Name (ARN) that uniquely identifies a specific billing view to use for the budget. | `string` | `null` | no |
| <a name="input_budget_type"></a> [budget\_type](#input\_budget\_type) | Whether this budget tracks monetary cost or usage. | `string` | `"COST"` | no |
| <a name="input_cost_filter"></a> [cost\_filter](#input\_cost\_filter) | Cost filters to apply to the budget | `map(any)` | `{}` | no |
| <a name="input_cost_types"></a> [cost\_types](#input\_cost\_types) | Cost types to apply to the budget | <pre>object({<br/>    include_credit             = optional(bool, false)<br/>    include_discount           = optional(bool, false)<br/>    include_other_subscription = optional(bool, false)<br/>    include_recurring          = optional(bool, false)<br/>    include_refund             = optional(bool, false)<br/>    include_subscription       = optional(bool, false)<br/>    include_support            = optional(bool, false)<br/>    include_tax                = optional(bool, false)<br/>    include_upfront            = optional(bool, false)<br/>    use_amortized              = optional(bool, true)<br/>    use_blended                = optional(bool, false)<br/>  })</pre> | `{}` | no |
| <a name="input_limit_amount"></a> [limit\_amount](#input\_limit\_amount) | The amount of cost or usage being measured for a budget | `string` | `null` | no |
| <a name="input_limit_unit"></a> [limit\_unit](#input\_limit\_unit) | The unit of measurement used for the budget forecast, actual spend, or budget threshold | `string` | `"USD"` | no |
| <a name="input_name"></a> [name](#input\_name) | Budget name. Either name or name\_prefix must be provided, but not both | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Budget name prefix. Either name or name\_prefix must be provided, but not both | `string` | `null` | no |
| <a name="input_notifications"></a> [notifications](#input\_notifications) | List of notifications for the budget. Each notification defines threshold, type, and subscribers. | <pre>list(object({<br/>    comparison_operator        = optional(string, "GREATER_THAN")<br/>    notification_type          = optional(string, "FORECASTED")<br/>    subscriber_email_addresses = optional(list(string), [])<br/>    subscriber_sns_topic_arns  = optional(list(string), [])<br/>    threshold                  = optional(number, 100)<br/>    threshold_type             = optional(string, "PERCENTAGE")<br/>  }))</pre> | `[]` | no |
| <a name="input_planned_limit"></a> [planned\_limit](#input\_planned\_limit) | A list of planned budget limits. Each limit defines a budget amount, start time, and optional unit. | <pre>list(object({<br/>    amount     = number<br/>    start_time = string<br/>    unit       = string<br/>  }))</pre> | `[]` | no |
| <a name="input_time_period_end"></a> [time\_period\_end](#input\_time\_period\_end) | The end of the time period covered by the budget. There are no restrictions on the end date. `Format: 2017-01-01_12:00`. | `string` | `null` | no |
| <a name="input_time_period_start"></a> [time\_period\_start](#input\_time\_period\_start) | The start of the time period covered by the budget. If not provided, defaults to the current date. `Format: 2017-01-01_12:00`. | `string` | `null` | no |
| <a name="input_time_unit"></a> [time\_unit](#input\_time\_unit) | The length of time until a budget resets the actual and forecasted spend | `string` | `"MONTHLY"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

## Licensing

100% Open Source and licensed under the Apache License Version 2.0. See [LICENSE](https://github.com/schubergphilis/terraform-aws-mcaf-budgets/blob/main/LICENSE) for full details.
