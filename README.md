# Deeper Network CLI (ALPHA)
 Collection of command line scripts composing an <u>**UNOFFICIAL**</u> Command Line Interface for the Deeper Network devices.
 All derived from the GUI. It can handle most stats, some configurations and some actions, like reboot.
 It is written using only curl requests in bash, so it should work on any linux distro.
 You may also use a docker image to run this script. See the [Docker](#docker) section for more information.

## Disclaimer
 This is a mostly untested work in progress. 
 Use at your own risk.

## Features
- Thought to work only withtin your network, no external dependencies.
- Handles ip ranges (in CIDR) and lists of arguments, where GUI can only handle a single IP or domain.
- You can send <u>info</u> log messages to the device.
- Host is set through env var `DEEPER_API_HOST`(defaults to 34.34.34.34)

## Requirements
 - Docker (optional)
 - Linux Shell (if not using docker)
 - Curl (if not using docker)

## Usage

### Docker (used for testing)
 1. Build the image
   
    ```bash
        docker build -t deeper-network-cli:alpha .
    ```
 2. Run the image

    ```bash
        docker run --rm deeper-network-cli:alpha <IP RANGE> <COUNTRY CODE> <USERNAME> <PASSWORD>
    ```
    It only adds, for the moment. If you wish to delete using docker image just edit the dockerfile and switch the comment between lines 10 and 11. And off course build the image again.
 3. You could also change the entrypoint script at runtime and use any of the [Shell](#shell) section scripts:

    ```bash
        docker run --rm --entrypoint ./opt/<SCRIPT>.sh deeper-network-cli:alpha <ARGUMENTS>
    ```

    Example:

    ```bash
        docker run --rm --entrypoint ./opt/getToken.sh deeper-network-cli:alpha teste paswword
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