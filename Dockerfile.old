FROM debian

ARG DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash", "-euxo", "pipefail", "-c"]

LABEL org.opencontainers.image.authors="Jason Miller <jakeadmin@gmail.com>" \
	org.opencontainers.image.title="PHP8.1.x" \
	org.opencontainers.image.description="Debian with PHP 8.1.0 (bleeding edge)" \
	org.opencontainers.image.licenses="Apache-2.0" \
	org.opencontainers.image.url="https://github.com/jake5253/php" \
	org.opencontainers.image.source="https://github.com/jake5253/php"

ENV LANG C.UTF-8
ENV TERM=xterm

# Build Tools
RUN \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    wget \
    git \
    cron \
    build-essential \
    libgccjit-8-dev \
    libzip-dev \
    autoconf \
    re2c \
    bison \
    libxml2-dev \
    pkg-config \
    libsqlite3-dev \
    libsqlite3-0 \
    libssl-dev \
    screen

# Fix CA Certs
RUN \
    apt-get install -y --reinstall ca-certificates \
    && mkdir /usr/local/share/ca-certificates/cacert.org \
    && wget -P /usr/local/share/ca-certificates/cacert.org http://www.cacert.org/certs/root.crt http://www.cacert.org/certs/class3.crt \
    && update-ca-certificates \
    && git config --global http.sslCAinfo /etc/ssl/certs/ca-certificates.crt;

# make needed folders
RUN \
    mkdir -p /usr/local/bin /usr/local/lib /usr/local/src /etc/cron.d; \
    chmod 0755 /usr/local/bin /usr/local/src /usr/local/lib /etc/cron.d;

# get setup stuff from github
RUN \
    git clone https://github.com/jake5253/php /root/setup/

# crontab setup
# Runs, by default, every Sunday at 00:01 (12:01AM)
ADD crontab /etc/cron.d/weekly-phpupdate
RUN chmod 0644 /etc/cron.d/weekly-phpupdate;
ADD ./cronjob /etc/cron.d/cronjob;
RUN chmod +x /etc/cron.d/cronjob;

# Create cron log file
RUN touch /var/log/cron.log;


# PHP bleeding edge
RUN /usr/local/bin/cronjob;
RUN cp /usr/local/src/php-src/php.ini-production /usr/local/lib/php.ini;


# Remove php source to save space now. We will get an update on [Sunday]
RUN rm -rf /usr/local/src/php-src;

# clean up apt-get
RUN \
    rm -rf /var/lib/apt/lists/*

# PHP.ini setup
ADD phpenmod.sh /usr/local/bin/phpenmod
RUN chmod +x /usr/local/bin/phpenmod
RUN /usr/local/bin/phpenmod apcu bcmath bz2 calendar dba enchant exif ffi gd gettext gmp imagick imap intl ldap memcached monodb mysqli opcache pdo_dblib pdo_mysql pdo_pgsql pgsql pspell redis shmop snmp sockets sqlite3 tidy xsl yaml zip

# COMPOSER
RUN \
	curl -sSL https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer ; \
	chmod +x /usr/local/bin/composer

#PHP Built-in server
COPY phpserv.sh /usr/local/bin/phpserv
RUN \
    chmod +x /usr/local/bin/phpserv

# ENTRYPOINT
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh ; \
	#sed -i -e 's/\r$//' /usr/local/bin/entrypoint.sh ; \
	mkdir /entrypoint.d

#WORKDIR /var/www/html
VOLUME /var/www/html

EXPOSE 80 443

ENTRYPOINT ["entrypoint.sh"]
CMD ["screen -dmS 'phpserv' /usr/local/bin/phpserv"]
