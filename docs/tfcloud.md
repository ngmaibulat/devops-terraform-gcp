-   Backend
-   Versioned State files
-   Runner
-   Secrets/Vars
-   Workspaces
-   Audit/Policies/Security/Sentinel
-   Private Modules

```s
# Allowed Types
allowed_types = [
    "t2.small",
    "t2.medium",
    "t2.large",
]

# Main rule
main = rule {
    validate_ec2_instance_types(allowed_types)
}
```
