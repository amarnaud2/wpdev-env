FROM wordpress:php8.2-apache

# Installer WP-CLI
RUN apt-get update && apt-get install -y \
    netcat-openbsd \
    curl \
    less \
    && rm -rf /var/lib/apt/lists/* \
    && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# PHP extensions si nécessaire
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Config PHP
COPY php.ini /usr/local/etc/php/php.ini
COPY mailhog.ini /usr/local/etc/php/conf.d/mailhog.ini

# Scripts init
COPY setup.sh /usr/local/bin/setup.sh
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
COPY wait-for-it.sh /usr/local/bin/wait-for-it.sh
RUN chmod +x /usr/local/bin/*.sh

ENTRYPOINT ["entrypoint.sh"]
CMD ["apache2-foreground"]
