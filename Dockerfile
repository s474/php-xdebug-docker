FROM php:7.4-apache

# system dependecies
RUN apt-get update \
 && apt-get install -y \
 git
 #libssl-dev \
 #libmcrypt-dev \
 #libicu-dev \
 #libpq-dev \
 #libjpeg62-turbo-dev \
 #libjpeg-dev  \
 #libpng-dev \
 #zlib1g-dev \
 #libonig-dev \
 #libxml2-dev \
 #libzip-dev \
 #unzip

# PHP dependencies
#RUN docker-php-ext-install
 #gd \
 #intl \
 #mbstring \
 #pdo \
 #pdo_mysql \
 #mysqli \
 #zip

# Xdebug
RUN pecl install xdebug \
 && docker-php-ext-enable xdebug \
 && echo 'zend_extension=xdebug' >> /usr/local/etc/php/conf.d/xdebug.ini \
 && echo 'xdebug.mode=develop,debug' >> /usr/local/etc/php/conf.d/xdebug.ini \
 && echo 'xdebug.client_host=host.docker.internal' >> /usr/local/etc/php/conf.d/xdebug.ini \
 && echo 'xdebug.start_with_request=yes' >> /usr/local/etc/php/conf.d/xdebug.ini \
 && echo 'xdebug.idekey="netbeans-xdebug"' >> /usr/local/etc/php/conf.d/xdebug.ini

# Apache
RUN a2enmod rewrite \
 && echo "ServerName docker" >> /etc/apache2/apache2.conf

# Composer
RUN curl -sS https://getcomposer.org/installer | php && \
 mv composer.phar /usr/local/bin/composer

WORKDIR /var/www/public