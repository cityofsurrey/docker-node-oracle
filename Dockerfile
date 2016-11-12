FROM node:7.1.0

ENV NPM_CONFIG_LOGLEVEL error

# INstall Yarn
RUN npm install -g yarn

# Install Oracle client
RUN apt-get update && \
    apt-get install libaio1 build-essential unzip curl -y

RUN mkdir -p opt/oracle
COPY ./oracle/ .

RUN unzip instantclient-basic-linux.x64-12.1.0.2.0.zip -d /opt/oracle && \
    unzip instantclient-sdk-linux.x64-12.1.0.2.0.zip -d /opt/oracle && \
    mv /opt/oracle/instantclient_12_1 /opt/oracle/instantclient && \
    ln -s /opt/oracle/instantclient/libclntsh.so.12.1 /opt/oracle/instantclient/libclntsh.so  && \
    ln -s /opt/oracle/instantclient/libocci.so.12.1 /opt/oracle/instantclient/libocci.so

ENV LD_LIBRARY_PATH="/opt/oracle/instantclient"
ENV OCI_HOME="/opt/oracle/instantclient"
ENV OCI_LIB_DIR="/opt/oracle/instantclient"
ENV OCI_INCLUDE_DIR="/opt/oracle/instantclient/sdk/include"

RUN echo '/opt/oracle/instantclient/' | tee -a /etc/ld.so.conf.d/oracle_instant_client.conf && ldconfig
