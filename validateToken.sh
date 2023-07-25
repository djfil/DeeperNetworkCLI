#!/bin/bash

api_host="${DEEPER_API_HOST:-34.34.34.34}"

# Check if all three arguments are provided
if [ $# -ne 2 ]; then
  echo "Usage: $0 <token>"
  exit 1
fi

# Parse the arguments
token=$1

# Build the cURL request command
curl_command="curl -k 'https://$api_host/api/admin/validateToken' -X 'GET' -H 'Authorization: bearer $bearer_token' -H 'Content-Type: application/json'"

# Print the cURL command to console
echo "Executing cURL command: $curl_command"

# Execute the cURL command
eval "$curl_command"
