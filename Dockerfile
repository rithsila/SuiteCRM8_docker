FROM ubuntu:latest

LABEL org.opencontainers.image.authors="khmertools7@gmail.com"

ENV TZ=Europe/London
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update
RUN apt -y upgrade
RUN apt-get install vim -y
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get install apache2 -y

RUN apt -y install ca-certificates apt-transport-https software-properties-common
RUN add-apt-repository ppa:ondrej/php
RUN apt-get -y update
RUN apt-get install -y php8.1 libapache2-mod-php8.1
RUN apt-get install -y php8.1-fpm libapache2-mod-fcgid
RUN apt-get install -y php8.1-mysql
RUN apt-get install -y php8.1-curl php8.1-intl php8.1-zip php8.1-imap php8.1-gd

RUN a2enmod rewrite
RUN a2enconf php8.1-fpm

RUN apt install -y php8.1-xml php8.1-mbstring
RUN apt install -y zlib1g-dev libxml2-dev

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y nodejs \
    npm

RUN npm install -g @angular/cli
RUN npm install --global yarn

CMD ["apachectl", "-D", "FOREGROUND"]

EXPOSE 80
