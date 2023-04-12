#!/bin/bash

# Check if environment variables are set or use the provided values
SUBSCRIPTION_ID=${SUBSCRIPTION_ID:-"<Your-Azure-Subscription-ID>"}
TENANT_ID=${TENANT_ID:-"<Your-Azure-AD-Tenant-ID>"}
APP_DISPLAY_NAME=${APP_DISPLAY_NAME:-"<Your-App-Display-Name>"}
APP_REPLY_URL=${APP_REPLY_URL:-"<Your-App-Reply-URL>"}

# Sign in to your Azure account
az login

# Set your subscription
az account set --subscription $SUBSCRIPTION_ID

# Create a new app registration
app_registration=$(az ad app create --display-name "$APP_DISPLAY_NAME" --reply-urls "$APP_REPLY_URL" --available-to-other-tenants false --query "{appId: appId, objectId: objectId}" -o json)

# Extract the App ID and Object ID from the JSON response
APP_ID=$(echo $app_registration | jq -r '.appId')
OBJECT_ID=$(echo $app_registration | jq -r '.objectId')

# Create a new service principal for the app registration
az ad sp create --id $APP_ID

# Assign the required roles to the service principal
az role assignment create --assignee $APP_ID --role "Contributor"

# Output the App ID, Object ID, and Tenant ID
echo "App ID: $APP_ID"
echo "Object ID: $OBJECT_ID"
echo "Tenant ID: $TENANT_ID"

# Sign out of your Azure account
az logout
