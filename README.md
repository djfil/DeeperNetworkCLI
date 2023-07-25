# Deeper Network CLI (ALPHA)
 Command Line Interface for the Deeper Network device.
 It can handle most stats, some configurations and some actions, like reboot.
 It is written using only curl and bash, so it should work on any linux distro.
 You may also use a docker image to run this script. See the [Docker](#docker) section for more information.

## Disclaimer
 This is a mostly untested work in progress.
 For the moment it only communicates with the device within its network (such so that the IP 34.34.34.34 ids the device).

## Features
- Thought to work only withtin your network, no external dependencies.
- Handles ranges and lists of arguments, where GUI can only handle a single IP.
- You can send info log messages to the device.

## Requirements
 - Docker (optional)
 - Linux Shell
 - Curl
 - Connection to the device's network

## Usage

### Docker (used for testing)
 1. Build the image
   
    ```bash
        docker build -t deeper-network-auto-requester .
    ```
 2. Run the image

    ```bash
        docker run --rm deeper-network-auto-requester <IP RANGE> <COUNTRY CODE> <USERNAME> <PASSWORD>
    ```
    It only adds, for the moment. If you wish to delete using docker image just edit the dockerfile and switch the comment between lines 10 and 11. And off course build the image again.
 3. You could also change the entrypoint script at runtime and use any of the [Shell](#shell) section scripts:

    ```bash
        docker run --rm --entrypoint ./opt/<SCRIPT>.sh deeper-network-auto-requester <ARGUMENTS>
    ```

    Example:

    ```bash
        docker run --rm --entrypoint ./opt/getToken.sh deeper-network-auto-requester teste paswword
    ```
   
### Shell

   Get Device ID

   ```bash
    ./getDeviceId.sh <USERNAME> <PASSWORD>
   ```

   Get DPN Mode
   
   ```bash
    ./getDpnMode.sh <USERNAME> <PASSWORD>
   ```

   Get Token (login)

   ```bash
    ./getToken.sh <USERNAME> <PASSWORD>
   ```

   List Tunnels
   
   ```bash
    ./listTunnels.sh <USERNAME> <PASSWORD>
   ```

   Add Tunnels
   
   ```bash
    ./addTunnel.sh <LIST REGION COUNTRY CODE PAIRS> <USERNAME> <PASSWORD>
   ```
   Example:
   ```bash
    ./addTunnels.sh "AMN BM ASC KG" teste password
   ```

   Delete Tunnels
   
   ```bash
    ./deleteTunnels.sh [LIST COUNTRY CODE] <USERNAME> <PASSWORD>
   ```
   Example:
   ```bash
    ./deleteTunnels.sh "BM KG" teste password
   ```

   Add IP to the White List

   ```bash
    ./addToWhiteList.sh <IP RANGE> <COUNTRY CODE> <USERNAME> <PASSWORD>
   ```
   Remove IP from the White List

   ```bash
    ./deleteFromWhiteList.sh <IP RANGE> <USERNAME> <PASSWORD>
   ```

   Set DPN Mode (full, smart, disabled)
   
   ```bash
    ./setDpnMode.sh <DPN MODE> <USERNAME> <PASSWORD>
    ./setDpnMode.sh full <COUNTRY CODE> <USERNAME> <PASSWORD>
   ```

   Get IP Routing Black List.
   
   ```bash
    ./getRoutingBlackList.sh <USERNAME> <PASSWORD>
   ```

   Get IP Routing White List
        
   ```bash
    ./getRoutingWhiteList.sh <USERNAME> <PASSWORD>
   ```

   Add Donain to the White List
   
   ```bash
    ./addDomainToWhiteList.sh [DOMAIN TUNNEL PAIR] <USERNAME> <PASSWORD>
   ```
   Example:
   ```bash
    ./addDomainToWhiteList.sh "google.com AMN whatsmyip.org AMN" teste password
   ```

   Delete Domain from the White List

   ```bash
    ./deleteDomainFromWhiteList.sh [DOMAINS] <USERNAME> <PASSWORD>
   ```
   Example:
   ```bash
    ./deleteDomainFromWhiteList.sh "google.com whatsmyip.org" teste password
   ```

   Add IP Range to the Black List
    
   ```bash
    ./addIpRangeToBlackList.sh <IP RANGE> <USERNAME> <PASSWORD>
   ```
   Example:
   ```bash
    ./addIpRangeToBlackList.sh 1.1.1.1/32 teste password
   ```

   Delete IP Range from the Black List
    
   ```bash
    ./deleteIpRangeFromBlackList.sh <IP RANGE> <USERNAME> <PASSWORD>
   ```
   Example:
   ```bash
    ./deleteIpRangeFromBlackList.sh 1.1.1.1/32 teste password
   ```

# Special Thanks
- Andrei Menshikh