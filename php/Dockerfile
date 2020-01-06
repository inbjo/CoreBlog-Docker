FROM php:7.3.13-fpm

LABEL maintainer="Flex<2345@mail.com>"

# ENV for Global
ENV TZ=Asia/Shanghai
ENV DEPENDENCIES curl gnupg git wget gcc g++
ENV PUID=1000
ENV PGID=1000

# ENV for PHP
ENV PHP_DEPENDENCIES \
                    unzip libwebp-dev libmcrypt-dev libmemcached-dev libbz2-dev libpng-dev \
                    libxpm-dev librabbitmq-dev libfreetype6-dev libjpeg-dev libssh-dev libzip-dev
ENV PHP_EXT_INSTALLED_PECL redis mcrypt
ENV PHP_COMPOSER_URL https://getcomposer.org/composer.phar
ENV PHP_COMPOSER_REPO https://mirrors.aliyun.com/composer/

USER root

# INSTALL PHP
RUN sed -i 's/deb.debian.org/mirrors.tuna.tsinghua.edu.cn/' /etc/apt/sources.list && \
    sed -i 's/security.debian.org/mirrors.tuna.tsinghua.edu.cn/' /etc/apt/sources.list && \
    sed -i 's/security-cdn.debian.org/mirrors.tuna.tsinghua.edu.cn/' /etc/apt/sources.list && \
  apt-get update \
  && apt-get install -y $PHP_DEPENDENCIES $DEPENDENCIES \
# INSTALL PHP EXT
  && pecl install -o -f $PHP_EXT_INSTALLED_PECL \
  && docker-php-ext-configure gd --with-gd --with-webp-dir --with-jpeg-dir \
      --with-png-dir --with-zlib-dir --with-xpm-dir --with-freetype-dir \
  && docker-php-ext-install opcache bcmath bz2 gd iconv mysqli pdo pdo_mysql zip sockets \
  && docker-php-ext-enable opcache redis mcrypt \
  && curl $PHP_COMPOSER_URL -o /usr/local/bin/composer \
  && chmod a+x /usr/local/bin/composer \
  && composer config -g repo.packagist composer $PHP_COMPOSER_REPO \
# USER
  && groupmod -o -g ${PGID} www-data \
  && usermod -o -u ${PUID} -g www-data www-data \
  && mkdir -p /www && chown -R www-data:www-data /www \
# CLEAN
  && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
  && apt-get -y remove $DEPENDENCIES \
  && apt-get purge -y --auto-remove \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && rm -rf /tmp/pear ~/.pearrc /var/log/lastlog /var/log/faillog

# After Build
WORKDIR /www

COPY sources.list /etc/apt/sources.list
COPY php.ini /usr/local/etc/php/
COPY php-fpm-www.conf /usr/local/etc/php-fpm.d/www.conf

CMD ["php-fpm"]
EXPOSE 9000