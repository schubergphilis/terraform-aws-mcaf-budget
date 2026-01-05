# Upgrading Notes

This document captures required refactoring when upgrading to a module version that contains breaking changes.

## Upgrading to v1.0.0

### Key Changes

- **Notifications** (breaking): `notification_threshold` and `subscriber_email_addresses` variables removed and replaced with `notifications` list
- **Budget configuration** (enhancement): `limit_amount` is now optional and one of three mutually exclusive options: `limit_amount`, `auto_adjust_data`, or `planned_limit`
- **Naming** (enhancement): `name` variable is now optional and must be used exclusively with `name_prefix` (exactly one required)
- **Time units** (enhancement): Added `"DAILY"` support to `time_unit` validation
- **Budget type** (enhancement): Added `budget_type` variable (defaults to `"COST"` for backward compatibility)
- **Time periods** (enhancement): Added `time_period_start` and `time_period_end` variables for custom time ranges
- **Billing views** (enhancement): Added `billing_view_arn` variable for billing view integration
- **Cost types** (enhancement): Added `use_blended` field to `cost_types` object

#### Variables

The `notification_threshold` and `subscriber_email_addresses` variables have been replaced with a flexible `notifications` list.

**Before:**

```hcl
module "budget" {
  source = "..."

  notification_threshold     = 100
  subscriber_email_addresses = ["example@example.com"]
}
```

**After:**

```hcl
module "budget" {
  source = "..."

  notifications = [
    {
      threshold                  = 100
      subscriber_email_addresses = ["example@example.com"]
    }
  ]
}
```
