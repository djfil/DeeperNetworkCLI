#!/bin/bash

# Check if all three arguments are provided
if [ $# -ne 3 ]; then
  echo "Usage: $0 [region country pair list] <username> <password>"
  exit 1
fi

# Parse the IP range, country code, and credentials from arguments
region_country_list=$1
username=$3
password=$4

# Run the getToken.sh script and store the output in a variable
token_output=$(/opt/getToken.sh $username $password)

# Extract the Bearer token using grep and cut
bearer_token=$(echo "$token_output" | grep -o '"token":"Bearer[^"]*' | cut -d '"' -f 4)
echo "Token: $bearer_token"

# Read the region and country codes from the list into arrays
mapfile -t regions_countries_array <<< "$region_country_list"

# Loop to execute cURL commands for each IP in the range
for ((i = 0; i < ${#regions_countries_array[@]}; i++)); do
  # Extract the region and country codes from the list
  current_pair=${regions_countries_array[i]}
  current_region=$(echo "$current_pair" | cut -d ' ' -f 1)
  current_country=$(echo "$current_pair" | cut -d ' ' -f 2)

  # Build the cURL request command
  curl_command="curl -k 'https://34.34.34.34/api/smartRoute/addTunnel' -X 'POST' -H 'Authorization: $bearer_token' --data-binary '{\"regionCode\":\"$current_region\",\"countryCode\":\"$current_country\"}' -H 'Content-Type: application/json'"

  # Print the cURL command to console
  echo "Executing cURL command: $curl_command"

  # Execute the cURL command
  eval "$curl_command"
done
