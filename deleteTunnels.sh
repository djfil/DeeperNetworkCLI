#!/bin/bash

# Check if all three arguments are provided
if [ $# -ne 3 ]; then
  echo "Usage: $0 [country list] <username> <password>"
  exit 1
fi

# Parse the IP range, country code, and credentials from arguments
country_list=$1
username=$2
password=$3

# Run the getToken.sh script and store the output in a variable
token_output=$(/opt/getToken.sh $username $password)

# Extract the Bearer token using grep and cut
bearer_token=$(echo "$token_output" | grep -o '"token":"Bearer[^"]*' | cut -d '"' -f 4)
echo "Token: $bearer_token"

# Build the cURL request command
curl_command="curl 'http://34.34.34.34/api/smartRoute/deleteTunnels' -X 'POST' -H 'Authorization: $bearer_token' --data-binary '[\""${country_list// /\",\"}"\"]' -H 'Content-Type: application/json'"

# Print the cURL command to console
echo "Executing cURL command: $curl_command"

# Execute the cURL command
eval "$curl_command"
