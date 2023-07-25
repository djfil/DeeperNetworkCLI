#!/bin/bash

# Check if two arguments are provided
if [ $# -ne 2 ]; then
  echo "Usage: $0 <username> <password>"
  exit 1
fi

# Parse the username and password from arguments
username=$1
password=$2

# Public key (replace this with your actual public key)
public_key="-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxZ9YwQ1CVM4zNHVNPxoD
Sz6uFGEcyHUOFkoA2hnijjJccCNRGnYlQmnCmaKPtCPiJ26ibXcL9BpfputJpE7Q
cJcJx8CN0Pr/MceYQraFS3UG+zNdI6tGzLDGrBoB+5WFSbK6aOdHFJfcoBfdULHb
g2eGp2IJwSPal3lFNwE/oTL3K1z7EiwbDq0LrY7FcwMGmG3EFaGtMxRy/cq3r0xR
M1V7WIu1I6gw463luLs6NFCdrY/fiXoSrXRf6sOTZClXeRhKjA6c0wLIxizgw6ll
4EeffYVBQSKlEjJJR2y7cxxbp1XkC19evxe0DYbnsemogDcSkmDCj75hsgwuzoTM
FwIDAQAB
-----END PUBLIC KEY-----"

# Encrypt the password with the public key using openssl
#encrypted_pass=$(echo -n "$password" | openssl pkeyutl -encrypt -pubin -inkey <(echo "$public_key") | base64 -w 0)
#encrypted_pass=$(echo -n "$password" | openssl rsautl -encrypt -pubin -inkey <(echo "$public_key") | base64 -w 0)
encrypted_pass=$(echo -n "${password}" | openssl rsautl -encrypt -pubin -inkey <(echo "$public_key") -oaep 2> /dev/null | base64 | tr -d '\n');

# Build the cURL request command
curl_command="curl -k 'https://34.34.34.34/api/admin/login' -X 'POST' --data-binary '{\"username\":\"$username\",\"password\":\"$encrypted_pass\"}' -H 'Content-Type: application/json'"

# Print the cURL command to the console
echo "Executing cURL command: $curl_command"

# Execute the cURL command
eval "$curl_command"
