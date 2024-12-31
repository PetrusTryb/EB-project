FROM prestashop/prestashop:1.7.8.10-7.3-apache

RUN cp -n -R -T -p /tmp/data-ps/prestashop/ /var/www/html
COPY --chown=www-data:www-data ./prod_images /var/www/html/img/p
RUN rm -rf /var/www/html/modules/ps_metrics
COPY --chown=www-data:www-data ./modules/ps_cashondelivery /var/www/html/modules/ps_cashondelivery
COPY --chown=www-data:www-data ./modules/ps_googleanalytics /var/www/html/modules/ps_googleanalytics
COPY --chown=www-data:www-data ./themes/myTheme /var/www/html/themes/myTheme
COPY --chown=www-data:www-data ./translations /var/www/html/translations
COPY --chown=www-data:www-data ./server.conf /etc/apache2/sites-available/server.conf
COPY --chown=www-data:www-data ./cert.pem /etc/ssl/certs/cert.pem
COPY --chown=www-data:www-data ./key.pem /etc/ssl/private/key.pem
COPY --chown=www-data:www-data ./StreamBuffer.php /var/www/html/vendor/swiftmailer/swiftmailer/lib/classes/Swift/Transport/StreamBuffer.php

COPY --chown=www-data:www-data prestashop.sql /seed/prestashop.sql
COPY --chown=www-data:www-data database-init.sh /tmp/init-scripts/database-init.sh
COPY --chown=www-data:www-data install.sh /tmp/docker_run.sh

RUN a2enmod ssl
RUN a2ensite server
RUN a2enmod headers