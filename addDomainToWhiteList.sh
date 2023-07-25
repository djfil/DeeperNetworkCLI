#!/bin/bash

# Check if all three arguments are provided
if [ $# -ne 3 ]; then
  echo "Usage: $0 [domain tunnel pair] <username> <password>"
  exit 1
fi

# Parse the domain tunnel pair list, and credentials from arguments
pairs_list=$1
username=$2
password=$3

# Run the getToken.sh script and store the output in a variable
token_output=$(/opt/getToken.sh $username $password)

# Extract the Bearer token using grep and cut
bearer_token=$(echo "$token_output" | grep -o '"token":"Bearer[^"]*' | cut -d '"' -f 4)
echo "Token: $bearer_token"

# Read the region and country codes from the list into arrays
mapfile -t pairs_array <<< "$pairs_list"

# Loop to execute cURL commands for each IP in the range
for ((i = 0; i < ${#pairs_array[@]}; i++)); do
  # Extract the region and country codes from the list
  current_pair=${pairs_array[i]}
  current_domain=$(echo "$current_pair" | cut -d ' ' -f 1)
  current_tunnel=$(echo "$current_pair" | cut -d ' ' -f 2)

  # Build the cURL request command
  curl_command="curl 'http://34.34.34.34/api/smartRoute/addToWhitelist/domain' -X 'POST' -H 'Authorization: $bearer_token' --data-binary '{\"domainName\":\"$current_domain\",\"tunnelCode\":\"$current_tunnel\"}' -H 'Content-Type: application/json'"

  # Print the cURL command to console
  echo "Executing cURL command: $curl_command"

  # Execute the cURL command
  eval "$curl_command"
done
