locals {
  ssoadmin_instance_arn = tolist(data.aws_ssoadmin_instances.this.arns)[0]
  managed_ps            = { for ps_name, ps_attrs in var.permission_sets : ps_name => ps_attrs if can(ps_attrs.managed_policies) }
  # create ps_name and managed policy maps list
  ps_policy_maps = flatten([
    for ps_name, ps_attrs in local.managed_ps : [
      for policy in ps_attrs.managed_policies : {
        ps_name    = ps_name
        policy_arn = policy
      } if can(ps_attrs.managed_policies)
    ]
  ])
  account_assignments = flatten([
    for assignment in var.account_assignments : [
      for account_id in assignment.account_ids : {
        principal_name = assignment.principal_name
        principal_type = assignment.principal_type
        permission_set = aws_ssoadmin_permission_set.this[assignment.permission_set]
        account_id     = account_id
      }
    ]
  ])
  groups = [for assignment in var.account_assignments : assignment.principal_name if assignment.principal_type == "GROUP"]
  users  = [for assignment in var.account_assignments : assignment.principal_name if assignment.principal_type == "USER"]
}