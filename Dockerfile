FROM ubuntu:latest

# Install required packages
RUN apt-get update && \
    apt-get install -y curl ipcalc openssl

# Copy the script to the container
COPY getToken.sh /opt/getToken.sh
#COPY addToWhiteList.sh /opt/curl_script.sh
COPY deleteFromWhiteList.sh /opt/curl_script.sh

# Set the script as executable
RUN chmod +x /opt/getToken.sh
RUN chmod +x /opt/curl_script.sh

# Set the entry point to the script
ENTRYPOINT ["/opt/curl_script.sh"]
