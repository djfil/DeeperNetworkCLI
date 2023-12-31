FROM ubuntu:latest

# Install required packages
RUN apt-get update && \
    apt-get install -y curl ipcalc openssl

# Copy the script to the container
COPY *.sh /opt/.

#COPY getToken.sh /opt/getToken.sh
#COPY getDeviceId.sh /opt/curl_script.sh
COPY addIPToWhiteList.sh /opt/curl_script.sh
#COPY deleteIPFromWhiteList.sh /opt/curl_script.sh
#COPY setDpnMode.sh /opt/curl_script.sh
#COPY getDpnMode.sh /opt/curl_script.sh
#COPY listTunnels.sh /opt/curl_script.sh
#COPY addTunnels.sh /opt/curl_script.sh
#COPY deleteTunnels.sh /opt/curl_script.sh
#COPY getRoutingWhitelist.sh /opt/curl_script.sh


# Set the script as executable
RUN chmod +x /opt/*.sh
RUN chmod +x /opt/getToken.sh
RUN chmod +x /opt/curl_script.sh

ENV DEEPER_API_HOST = 34.34.34.34

# Set the entry point to the script
ENTRYPOINT ["/opt/curl_script.sh"]
