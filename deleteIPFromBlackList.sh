#!/bin/bash

# Check if all three arguments are provided
if [ $# -ne 3 ]; then
  echo "Usage: $0 <ip_range> <username> <password>"
  exit 1
fi

# Parse the IP range, credentials from arguments
ip_range=$1
username=$2
password=$3

# Function to convert IP address to integer
ip_to_int() {
  local IFS='.'
  read -r ip1 ip2 ip3 ip4 <<< "$1"
  printf "%d\n" "$((ip1 * 256 ** 3 + ip2 * 256 ** 2 + ip3 * 256 + ip4))"
}

# Function to convert integer to IP address
int_to_ip() {
  local ip=$1
  printf "%d.%d.%d.%d\n" "$(((ip >> 24) & 255))" "$(((ip >> 16) & 255))" "$(((ip >> 8) & 255))" "$((ip & 255))"
}

# Run the getToken.sh script and store the output in a variable
token_output=$(/opt/getToken.sh $username $password)

# Extract the Bearer token using grep and cut
bearer_token=$(echo "$token_output" | grep -o '"token":"Bearer[^"]*' | cut -d '"' -f 4)
echo "Token: $bearer_token"

# Extract network address and prefix length from the CIDR range
read network_address prefix_length <<< $(echo "$ip_range" | awk -F '/' '{print $1, $2}')

# Calculate the total number of IP addresses in the range
total_ips=$((2 ** (32 - prefix_length)))

# Convert network address to integer
network_int=$(ip_to_int "$network_address")

# Loop to execute cURL commands for each IP in the range
for ((i = 0; i < total_ips; i++)); do
  # Calculate the current IP address
  current_ip=$(int_to_ip "$((network_int + i))")

  # Build the cURL request command
  curl_command="curl -k 'https://34.34.34.34/api/smartRoute/deleteFromBlacklist/ip' -X 'POST' -H 'Authorization: $bearer_token' --data-binary '[\"$current_ip\"]' -H 'Content-Type: application/json'"

  # Print the cURL command to console
  echo "Executing cURL command: $curl_command"

  # Execute the cURL command
  eval "$curl_command"
done
