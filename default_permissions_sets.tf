locals {
  default_permissions_sets_names = toset([
    "AWSPowerUserAccess",
    "AWSReadOnlyAccess",
    "AWSAdministratorAccess",
    "AWSServiceCatalogAdminFullAccess",
    "AWSOrganizationsFullAccess",
    "AWSServiceCatalogEndUserAccess"
  ])
}

data "aws_ssoadmin_permission_set" "defaults" {
  for_each = local.default_permissions_sets_names

  instance_arn = local.ssoadmin_instance_arn
  name = each.key
}