FROM php:8.2-fpm
WORKDIR /var/www
COPY index.php /var/www/html/index.php
COPY info.php /var/www/html/info.php
COPY zz-dogs.conf /usr/local/etc/php-fpm.d/zz-dogs.conf
RUN chown -R www-data:www-data /var/www
EXPOSE 9000
CMD ["php-fpm"]