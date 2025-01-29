# Set the Vault Token as a variable
$VAULT_TOKEN = Get-Content -Path "$HOME\.vault-token"

# Export the VAULT_ADDR
$VAULT_ADDR = 'http://127.0.0.1:8200'

# Enabled the AppRole auth method
$headers = @{
    "X-Vault-Token" = $VAULT_TOKEN
}

# Get the role-id for marvin
$response = Invoke-RestMethod -Method Get -Uri "$VAULT_ADDR/v1/auth/milliways/role/marvin/role-id" -Headers $headers
$role_id = $response.data.role_id

# Get the secret-id for marvin
$response = Invoke-RestMethod -Method Post -Uri "$VAULT_ADDR/v1/auth/milliways/role/marvin/secret-id" -Headers $headers
$secret_id = $response.data.secret_id

# Authenticate with the role-id and secret-id
$body = @{
    role_id = $role_id
    secret_id = $secret_id
}
$response = Invoke-RestMethod -Method Post -Uri "$VAULT_ADDR/v1/auth/milliways/login" -Headers $headers -Body ($body | ConvertTo-Json)
$response.auth.client_token

# Verify the token is valid
$body = @{
    token = $response.auth.client_token
}
Invoke-RestMethod -Method Post -Uri "$VAULT_ADDR/v1/auth/token/lookup-self" -Headers $headers -Body ($body | ConvertTo-Json)

