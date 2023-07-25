#!/bin/bash

# Check if all three arguments are provided
if [ $# -lt 3 ]; then
  echo "Usage: $0 <Message> <username> <password>."
  exit 1
fi

# Parse the arguments
mode=$1
username=$2
password=$3

# Run the getToken.sh script and store the output in a variable
token_output=$(/opt/getToken.sh $username $password)

# Extract the Bearer token using grep and cut
bearer_token=$(echo "$token_output" | grep -o '"token":"Bearer[^"]*' | cut -d '"' -f 4)
echo "Token: $bearer_token"

# Build the cURL request command
curl_command="curl 'http://34.34.34.34/api/admin/deeperLog' -X 'POST' -H 'Authorization: $bearer_token' --data-binary '{\"level\":\"info\",\"message\":\"$mode\"}' -H 'Content-Type: application/json'"

# Print the cURL command to console
echo "Executing cURL command: $curl_command"

# Execute the cURL command
eval "$curl_command"
