# terraform {
#   experiments = [module_variable_optional_attrs]
# }

variable "permission_sets" {
  description = "Map of maps containing Permission Set names as keys. See permission_sets description in README for information about map values."
  type        = map(
    object(
      {
        description=optional(string),
        managed_policies=list(string),
        session_duration=optional(string),
        tags=optional(map(string)),
        inline_policy=optional(string)
        boundary_customer=optional(string)
      }
    )
  )
  default = {
    "AdministratorAccess" = {
      description      = "Provides full access to AWS services and resources.",
      session_duration = "PT2H",
      managed_policies = ["arn:aws:iam::aws:policy/AdministratorAccess"]
    }
  }
}

variable "account_assignments" {
  description = "List of maps containing mapping between user/group, permission set and assigned accounts list. See account_assignments description in README for more information about map values."
  type = list(object({
    principal_name = string,
    principal_type = string,
    permission_set = string,
    account_ids    = list(string)
  }))

  default = []
}
