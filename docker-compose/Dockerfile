FROM prestashop/prestashop:1.7.8.10-7.3-apache

RUN cp -n -R -T -p /tmp/data-ps/prestashop/ /var/www/html
COPY --chown=www-data:www-data ./prod_images /var/www/html/img/p
COPY --chown=www-data:www-data ./modules/ps_cashondelivery /var/www/html/modules/ps_cashondelivery
COPY --chown=www-data:www-data ./modules/ps_googleanalytics /var/www/html/modules/ps_googleanalytics
COPY --chown=www-data:www-data ./themes/myTheme /var/www/html/themes/myTheme
COPY --chown=www-data:www-data ./translations /var/www/html/translations
COPY --chown=www-data:www-data ./server.conf /etc/apache2/sites-available/server.conf
COPY --chown=www-data:www-data ./cert.pem /etc/ssl/certs/cert.pem
COPY --chown=www-data:www-data ./key.pem /etc/ssl/private/key.pem
COPY --chown=www-data:www-data ./StreamBuffer.php /var/www/html/vendor/swiftmailer/swiftmailer/lib/classes/Swift/Transport/StreamBuffer.php

COPY --chown=www-data:www-data prestashop.sql /seed/prestashop.sql

RUN sed -r -i '/INSERT INTO `ps_connections_source`/,/;/d' /seed/prestashop.sql
RUN sed -r -i '/INSERT INTO `ps_connections`/,/;/d' /seed/prestashop.sql
COPY --chown=www-data:www-data database-init.sh /tmp/init-scripts/database-init.sh
COPY --chown=www-data:www-data install.sh /tmp/docker_run.sh
RUN chmod +x /tmp/docker_run.sh
RUN chmod +x /tmp/init-scripts/database-init.sh

RUN mv /var/www/html/install /var/www/html/install4577/
RUN mv /var/www/html/admin /var/www/html/admin4577/

RUN a2enmod ssl
RUN a2ensite server
RUN a2enmod headers

RUN apt-get update && apt-get install -y libmemcached-dev zlib1g-dev
RUN pecl install memcached
RUN docker-php-ext-enable memcached