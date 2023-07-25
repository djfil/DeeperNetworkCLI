#!/bin/bash

# Check if all three arguments are provided
if [ $# -ne 2 ]; then
  echo "Usage: $0 <username> <password>"
  exit 1
fi

# Parse the arguments
username=$1
password=$2

# Run the getToken.sh script and store the output in a variable
token_output=$(/opt/getToken.sh $username $password)

# Extract the Bearer token using grep and cut
bearer_token=$(echo "$token_output" | grep -o '"token":"Bearer[^"]*' | cut -d '"' -f 4)
echo "Token: $bearer_token"

# Build the cURL request command
curl_command="curl 'http://34.34.34.34/api/license/queryRequired' -X 'GET' -H 'Authorization: $bearer_token' -H 'Content-Type: application/json'"

# Print the cURL command to console
echo "Executing cURL command: $curl_command"

# Execute the cURL command
eval "$curl_command"
