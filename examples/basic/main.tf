locals {
  aws_budgets = {
    consolidated = {
      cost_filter  = {}
      limit_amount = "999.0"
    }
    account = {
      cost_filter  = { LinkedAccount = ["111111111111"] }
      limit_amount = "111.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}

module "budgets" {
  for_each = local.aws_budgets
  source   = "../.."

  name                       = each.key
  cost_filter                = each.value.cost_filter
  limit_amount               = each.value.limit_amount
  subscriber_email_addresses = ["example@example.com"]
}
