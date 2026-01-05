provider "aws" {
  region = "eu-west-1"
}

module "planned_budget" {
  source = "../.."

  name_prefix = "planned"

  planned_limit = [
    {
      amount     = 10000
      start_time = "2026-01-01_00:00"
      unit       = "USD"
    },
    {
      amount     = 15000
      start_time = "2026-04-01_00:00"
      unit       = "USD"
    },
    {
      amount     = 20000
      start_time = "2026-07-01_00:00"
      unit       = "USD"
    }
  ]

  notifications = [
    {
      subscriber_email_addresses = ["example@example.com"]
    }
  ]
}
