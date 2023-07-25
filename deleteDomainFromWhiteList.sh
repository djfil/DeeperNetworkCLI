#!/bin/bash

api_host="${DEEPER_API_HOST:-34.34.34.34}"

# Check if all three arguments are provided
if [ $# -ne 3 ]; then
  echo "Usage: $0 [domain list] <username> <password>"
  exit 1
fi

# Parse the domain list, and credentials from arguments
domain_list=$1
username=$2
password=$3

# Run the getToken.sh script and store the output in a variable
token_output=$(/opt/getToken.sh $username $password)

# Extract the Bearer token using grep and cut
bearer_token=$(echo "$token_output" | grep -o '"token":"Bearer[^"]*' | cut -d '"' -f 4)
echo "Token: $bearer_token"

# Build the cURL request command
curl_command="curl -k 'https://$api_host/api/smartRoute/deleteFromWhitelist/domain' -X 'POST' -H 'Authorization: $bearer_token' --data-binary '[\""${domain_list// /\",\"}"\"]' -H 'Content-Type: application/json'"

# Print the cURL command to console
echo "Executing cURL command: $curl_command"

# Execute the cURL command
eval "$curl_command"
