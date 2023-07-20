#!/bin/bash

# Check if all three arguments are provided
if [ $# -lt 3 ]; then
  echo "Usage: $0 <Mode> <username> <password> \n if mode is full specify tunnel code: $0 <Mode> <tunnelCode> <username> <password> \n Note: Killswitch is alsways false for now."
  exit 1
fi

# Parse the arguments
mode=$1
if [ "$mode" == "full" ]; then
  tunnel=$2
  username=$3
  password=$4
else
  username=$2
  password=$3
fi

# Run the getToken.sh script and store the output in a variable
token_output=$(/opt/getToken.sh $username $password)

# Extract the Bearer token using grep and cut
bearer_token=$(echo "$token_output" | grep -o '"token":"Bearer[^"]*' | cut -d '"' -f 4)
echo "Token: $bearer_token"

# Build the cURL request command
if [ "$mode" == "full" ]; then
  curl_command="curl 'http://34.34.34.34/api/smartRoute/setDpnMode' -X 'POST' -H 'Authorization: $bearer_token' --data-binary '{\"dpnMode\":\"$mode\",\"tunnelCode\":\"$tunnel\",\"killSwitch\":false}' -H 'Content-Type: application/json'"
else
  curl_command="curl 'http://34.34.34.34/api/smartRoute/setDpnMode' -X 'POST' -H 'Authorization: $bearer_token' --data-binary '{\"dpnMode\":\"$mode\"}' -H 'Content-Type: application/json'"
fi

# Print the cURL command to console
echo "Executing cURL command: $curl_command"

# Execute the cURL command
eval "$curl_command"
