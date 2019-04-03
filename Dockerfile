FROM ubuntu:16.04

LABEL description="Devspaces implementation for PHP-MySql developer environment"

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=C.UTF-8

RUN apt-get update \
 && apt-get install -y build-essential curl \
	dialog \
    git \ 
    mc \
    nano \
    net-tools \
    nginx \
    software-properties-common \
    sudo \
    vim \
    wget \
 && apt-get clean \
 && add-apt-repository ppa:ondrej/php \
 && apt-get update \
 && apt-get install -y php7.1 \
    php7.1 \
    php7.1-cli \
    php7.1-common \
    php7.1-json \ 
    php7.1-opcache \
    php7.1-mysql \
    php7.1-mbstring \
    php7.1-mcrypt \
    php7.1-zip \
    php7.1-fpm \
 && apt-get clean    

# Installing MySql Server
RUN apt-get update \
 && apt-get -y install mysql-server \       
 && apt-get clean \
 && usermod -d /var/lib/mysql/ mysql \
 && chown -R mysql /var/lib/mysql \    
 && chgrp -R mysql /var/lib/mysql \
 && chmod -R 775 /var/lib/mysql \
 && sed -i "s;bind-address.*;bind-address=0.0.0.0;g" /etc/mysql/mysql.conf.d/mysqld.cnf 
    
ADD entrypoint.tar.gz .    

RUN chmod u+x /entrypoint.sh
    
WORKDIR /data    
    
ENTRYPOINT ["/entrypoint.sh"]