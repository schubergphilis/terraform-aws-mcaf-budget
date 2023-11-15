# terraform-aws-mcaf-budget

Terraform module to create and manage an AWS Budget.

> [!IMPORTANT]
> There is a known limitation within AWS Budgets. AWS Budgets is not in complete parity with Cost Explorer. Currently, Budgets does not support charge types related to Savings Plans or reservation applied usage. This means that the spend you see in AWS Budgets can be different then you see in AWS Cost Explorer or your AWS bill.

As a temporary work-around, you needs to select the following charge types in Cost Explorer after clicking on "View in Cost Explorer" in your AWS Budget:

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
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.52.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.52.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_budgets_budget.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/budgets_budget) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_limit_amount"></a> [limit\_amount](#input\_limit\_amount) | The amount of cost or usage being measured for a budget | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Budget name | `string` | n/a | yes |
| <a name="input_subscriber_email_addresses"></a> [subscriber\_email\_addresses](#input\_subscriber\_email\_addresses) | E-mail addresses to notify when the threshold is met | `list(string)` | n/a | yes |
| <a name="input_cost_filter"></a> [cost\_filter](#input\_cost\_filter) | Cost filters to apply to the budget | `map(any)` | `{}` | no |
| <a name="input_notification_threshold"></a> [notification\_threshold](#input\_notification\_threshold) | % Threshold when the notification should be sent | `string` | `100` | no |
| <a name="input_time_unit"></a> [time\_unit](#input\_time\_unit) | The length of time until a budget resets the actual and forecasted spend. Valid values: MONTHLY, QUARTERLY, ANNUALLY | `string` | `"MONTHLY"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

## Licensing

100% Open Source and licensed under the Apache License Version 2.0. See [LICENSE](https://github.com/schubergphilis/terraform-aws-mcaf-budgets/blob/main/LICENSE) for full details.
