FROM php:5-apache

RUN mkdir -p /usr/lib/oracle/ && mkdir -p /etc/php5/apache2/conf.d/

COPY instantclient-basic-linux.x64-12.2.0.1.0.zip /usr/lib/oracle/
COPY instantclient-sdk-linux.x64-12.2.0.1.0.zip /usr/lib/oracle/
COPY oci8.ini /tmp/

RUN cd /usr/lib/oracle/ && \
    ls && \
    apt-get update && \
    apt-get install -y apt-utils && \
    apt-get install -y unzip && \
    unzip instantclient-basic-linux.x64-12.2.0.1.0.zip && \
    unzip instantclient-sdk-linux.x64-12.2.0.1.0.zip && \
    ln -s /usr/lib/oracle/instantclient_12_2/libclntsh.so.12.1 /usr/lib/oracle/instantclient_12_2/libclntsh.so && \
    apt-get install -y libaio-dev php5-dev && \
    mkdir -p /usr/local/etc/php/conf.d/ && \
    cp /tmp/oci8.ini /usr/local/etc/php/conf.d/ && \
    yes 'instantclient,/usr/lib/oracle/instantclient_12_2' | pecl install oci8-2.0.12