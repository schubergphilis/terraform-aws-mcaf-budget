provider "aws" {
  region = "eu-west-1"
}

module "auto_adjusting_budget" {
  source = "../.."

  name_prefix = "auto-adjusting"

  auto_adjust_data = {
    auto_adjust_type = "FORECAST"
  }

  notifications = [
    {
      subscriber_email_addresses = ["example@example.com"]
    }
  ]
}
