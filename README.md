# Deeper Network Auto Requester (ALPHA)
 For the moment it only automates the insertion and removal of ip ranges following the CIDR notation into the Deeper Network device configuration.
 You may also use a docker image to run this script. See the [Docker](#docker) section for more information.

 This is a work in progress.

 ## Requirements
  - Docker (optional)
  - Linux Shell
  - Curl

 ## Usage

  ### Docker
   1. Build the image
    ```bash
    docker build -t deeper-network-auto-requester .
    ```
   2. Run the image
    ```bash
    docker run --rm deeper-network-auto-requester <IP RANGE> <COUNTRY CODE> <USERNAME> <PASSWORD>
    ```
   It only adds, for the moment. If you wish to delete using docker image just edit the dockerfile and switch the comment between lines 9 and 10. And off course build the image again.
   To remove the country code is not used.
  ### Shell
   Add to the White List
   ```bash
    ./opt/addToWhiteList.sh <IP RANGE> <COUNTRY CODE> <USERNAME> <PASSWORD>
   ```
   Remove from the White List
   ```bash
    ./opt/deleteFromWhiteList.sh <IP RANGE> <USERNAME> <PASSWORD>
   ```

# Special Thanks
- Andrei Menshikh