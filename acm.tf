provider "aws" {
  alias = "acm"
}

provider "aws" {
  alias = "route53"
}

module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 4.0"

  providers = {
    aws = aws.acm
  }

  domain_name = var.domain

  subject_alternative_names = [
    "*.${var.domain}"
  ]

  validation_method = "DNS"

  create_route53_records  = false
  validation_record_fqdns = module.route53_records.validation_route53_record_fqdns
}

module "route53_records" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 4.0"

  providers = {
    aws = aws.route53
  }

  create_certificate          = false
  create_route53_records_only = true

  validation_method = "DNS"

  distinct_domain_names = module.acm.distinct_domain_names
  zone_id               = data.aws_route53_zone.zone.id

  acm_certificate_domain_validation_options = module.acm.acm_certificate_domain_validation_options
}
