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
<!-- END_TF_DOCS -->

## Licensing

100% Open Source and licensed under the Apache License Version 2.0. See [LICENSE](https://github.com/schubergphilis/terraform-aws-mcaf-budgets/blob/main/LICENSE) for full details.
