FROM php:5.6-apache
MAINTAINER Christian Simon <simon@illucit.com>

ENV SQUIRRELMAIL_VERSION 1.4.22

# install the PHP extensions we need
RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y locales-all libcurl4-gnutls-dev libpng-dev libssl-dev libc-client2007e-dev libkrb5-dev debconf-utils unzip cron re2c python tree libjpeg-dev libpng-dev wget \
  && export DEBCONF_FRONTEND=noninteractive \
  && echo 'locales locales/locales_to_be_generated de_DE.UTF-8 UTF-8' | debconf-set-selections \
  && echo 'locales locales/default_environment_locale de_DE.UTF-8' | debconf-set-selections \
  && apt-get install -y locales \
  && docker-php-ext-configure imap --with-imap-ssl --with-kerberos \
  && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
  && docker-php-ext-install mysqli curl gd zip mbstring imap iconv \
  && rm -rf /var/lib/apt/lists/* \
  && pear install DB \
  && echo 'register_globals = Off' > /usr/local/etc/php/conf.d/squirrelmail.ini \
  && echo 'magic_quotes_runtime = Off' >> /usr/local/etc/php/conf.d/squirrelmail.ini \
  && echo 'magic_quotes_gpc = Off' >> /usr/local/etc/php/conf.d/squirrelmail.ini \
  && echo 'file_upload = On' >> /usr/local/etc/php/conf.d/squirrelmail.ini \
  && echo 'error_reporting = E_ERROR' >> /usr/local/etc/php/conf.d/squirrelmail.ini

ENV SUIRRELMAIL_URL "https://sourceforge.net/projects/squirrelmail/files/stable/${SQUIRRELMAIL_VERSION}/squirrelmail-webmail-${SQUIRRELMAIL_VERSION}.tar.gz/download?use_mirror=heanet"
ENV LANG "de_DE.UTF-8"

RUN cd /var/www/html \
  && wget "${SUIRRELMAIL_URL}" -O squirrelmail-webmail-${SQUIRRELMAIL_VERSION}.tar.gz \
  && tar -xvzf squirrelmail-webmail-${SQUIRRELMAIL_VERSION}.tar.gz --strip-components=1 \
  && rm squirrelmail-webmail-${SQUIRRELMAIL_VERSION}.tar.gz \
  && chown -R www-data:www-data .


VOLUME /var/squirrelmail
