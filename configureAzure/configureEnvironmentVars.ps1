$tenantID = "b82a4829-cdd4-48de-b142-985c68d41b4c"
$subscriptionID = "0b55b4c7-3322-4eb8-988a-0cda8f823217"
$clientID = "55cf7e60-fd77-4c88-ae74-0af1a23b7a37"
$clientSecret = "wYaZKPIEeweO6aElhPP.Cf7xgEy.=]33"

[Environment]::SetEnvironmentVariable("ARM_SUBSCRIPTION_ID",$subscriptionID , "User")
[Environment]::SetEnvironmentVariable("ARM_CLIENT_ID",$clientID, "User")
[Environment]::SetEnvironmentVariable("ARM_CLIENT_SECRET",$clientSecret  , "User")

# [Environment]::SetEnvironmentVariable("TF_VAR_tenant_id",$tenantID, "User")
# [Environment]::SetEnvironmentVariable("TF_VAR_subscription_id",$subscriptionID , "User")
# [Environment]::SetEnvironmentVariable("TF_VAR_client_id",$clientID, "User")
# [Environment]::SetEnvironmentVariable("TF_VAR_client_secret",$clientSecret , "User")