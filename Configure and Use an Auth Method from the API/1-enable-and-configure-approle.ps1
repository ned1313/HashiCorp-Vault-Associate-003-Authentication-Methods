# Start the Vault dev server
vault server -dev

# Set the Vault Token as a variable
$VAULT_TOKEN = Get-Content -Path "$HOME\.vault-token"

# Export the VAULT_ADDR
$VAULT_ADDR = 'http://127.0.0.1:8200'

# Enabled the AppRole auth method
$headers = @{
    "X-Vault-Token" = $VAULT_TOKEN
}

$body = @{
    type = "approle"
}

Invoke-RestMethod -Method Post -Uri "$VAULT_ADDR/v1/sys/auth/milliways" -Headers $headers -Body ($body | ConvertTo-Json)

# Verify the AppRole authentication method is enabled
Invoke-RestMethod -Uri "$VAULT_ADDR/v1/sys/auth/milliways" -Method Get -Headers $headers


# Create the marvin role
$roleBody = @{
    role_name = "marvin"
    secret_id_num_uses = 1
    secret_id_ttl = "2h"
}

Invoke-RestMethod -Method Post -Uri "$VAULT_ADDR/v1/auth/milliways/role/marvin" -Headers $headers -Body ($roleBody | ConvertTo-Json)

# Read the new role
$response = Invoke-RestMethod -Method Get -Uri "$VAULT_ADDR/v1/auth/milliways/role/marvin" -Headers $headers
$response.data