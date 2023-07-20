# Deeper Network CLI (ALPHA)
 For the moment it only automates the insertion and removal of ip ranges following the CIDR notation into the Deeper Network device configuration.
 You may also use a docker image to run this script. See the [Docker](#docker) section for more information.

 This is a work in progress.

## Features
- Thought to work only withtin your network, no external dependencies.
- Handles ranges and lists of arguments.

## Requirements
 - Docker (optional)
 - Linux Shell
 - Curl

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

   Add to the White List

   ```bash
    ./addToWhiteList.sh <IP RANGE> <COUNTRY CODE> <USERNAME> <PASSWORD>
   ```
   Remove from the White List

   ```bash
    ./deleteFromWhiteList.sh <IP RANGE> <USERNAME> <PASSWORD>
   ```

   Set DPN Mode (full, smart, disabled)
   
   ```bash
    ./setDpnMode.sh <DPN MODE> <USERNAME> <PASSWORD>
    ./setDpnMode.sh full <COUNTRY CODE> <USERNAME> <PASSWORD>
   ```

# Special Thanks
- Andrei Menshikh