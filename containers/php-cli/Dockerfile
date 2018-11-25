FROM php:7.2-cli-alpine3.8

ARG host_group_id
ARG host_user_id

ENV ZOOKEEPER_VER=3.4.13

RUN set -x \
    && OLD_UID=$(id -u www-data) \
    && OLD_GID=$(id -g www-data) \
    && deluser www-data \
    && addgroup -g ${host_group_id} -S www-data \
    && adduser -u ${host_user_id} -G www-data -D -S www-data \
    && find / -user ${OLD_UID} -exec chown www-data {} \; \
    && find / -group ${OLD_GID} -exec chgrp www-data {} \; \
    && NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) \
    && apk update \
    && apk add --no-cache --virtual .buildDeps \
        autoconf \
        g++ \
        gcc \
        libc-dev \
        make \
        re2c \
        wget \
    && apk add --no-cache --virtual .buildDeps-postgres \
        postgresql-dev \
    && apk add --no-cache --virtual .buildDeps-intl \
        icu-dev \
    && apk add --no-cache --virtual .buildDeps-gd \
        freetype-dev \
        libjpeg-turbo-dev \
        libpng-dev \
        libwebp-dev \
    && apk add --no-cache --virtual .buildDeps-soap \
        libxml2-dev \
    && apk add --no-cache --virtual .buildDeps-gmagick \
        graphicsmagick-dev \
#    && apk add --no-cache --virtual .buildDeps-imagick \
#        imagemagick-dev \
    && apk add --no-cache --virtual .buildDeps-memcached \
        libmemcached-dev \
    && apk add --no-cache --virtual .buildDeps-rdkafka \
        librdkafka-dev \
#    && apk add --no-cache --virtual .buildDeps-pthreads \ #zts required
#        pcre-dev \
    && apk add --no-cache --virtual .runtimeDeps \
        git \
        jpegoptim \
        pngquant \
        optipng \
    && apk add --no-cache --virtual .runtimeDeps-postgres \
        postgresql \
    && apk add --no-cache --virtual .runtimeDeps-intl \
        icu-libs \
    && apk add --no-cache --virtual .runtimeDeps-gd \
        freetype \
        libjpeg-turbo \
        libpng \
        libwebp \
    && apk add --no-cache --virtual .runtimeDeps-gmagick \
        libtool \
        libgomp \
        graphicsmagick \
#    && apk add --no-cache --virtual .runtimeDeps-imagick \
#        imagemagick \
    && apk add --no-cache --virtual .runtimeDeps-memcached \
        libmemcached-libs \
    && apk add --no-cache --virtual .runtimeDeps-rdkafka \
        librdkafka \
    && cd /tmp \
    && wget -N -O- http://archive.apache.org/dist/zookeeper/zookeeper-$ZOOKEEPER_VER/zookeeper-$ZOOKEEPER_VER.tar.gz | tar zxvf - \
    && cd zookeeper-$ZOOKEEPER_VER/src/c \
    && ./configure --prefix=/usr/local/zookeeper \
    && make -j${NPROC} \
    && make install \
    && cd /tmp \
    && rm -rf /tmp/zookeeper-$ZOOKEEPER_VER \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/ --with-webp-dir=/usr/include/ \
    && docker-php-ext-install -j${NPROC} pgsql pdo_pgsql intl opcache pcntl gd exif zip soap \
    && pecl config-set php_ini /usr/local/etc/php/php.ini \
    && pear config-set php_ini /usr/local/etc/php/php.ini \
    && pecl install gmagick-beta \
#    && pecl install imagick \
    && pecl install memcached \
    && pecl install rdkafka \
    && pecl install redis \
    && pecl install xdebug \
    && git clone https://github.com/php-zookeeper/php-zookeeper.git /tmp/php-zookeeper \
    && cd /tmp/php-zookeeper \
    && phpize \
    && ./configure --with-libzookeeper-dir=/usr/local/zookeeper \
    && make -j${NPROC} \
    && make install \
    && cd /tmp \
    && rm -rf /tmp/php-zookeeper \
#    && git clone https://github.com/krakjoe/pthreads.git /tmp/pthreads \
#    && cd /tmp/pthreads \
#    && phpize \
#    && ./configure --enable-pthreads \
#    && make -j${NPROC} \
#    && make install \
#    && rm -rf /tmp/pthreads \
    && docker-php-ext-enable gmagick \
#    && docker-php-ext-enable imagick \
    && docker-php-ext-enable memcached \
    && docker-php-ext-enable rdkafka \
    && docker-php-ext-enable redis \
    && docker-php-ext-enable xdebug \
    && docker-php-ext-enable zookeeper \
#    && docker-php-ext-enable pthreads \
    && curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && composer global require hirak/prestissimo \
    && composer clear-cache \
    && wget https://phar.phpunit.de/phpunit.phar \
    && chmod +x phpunit.phar \
    && mv phpunit.phar /usr/local/bin/phpunit \
    && apk del \
        .buildDeps \
        .buildDeps-postgres \
        .buildDeps-intl \
        .buildDeps-gd \
        .buildDeps-soap \
        .buildDeps-gmagick \
#        .buildDeps-imagick \
        .buildDeps-memcached \
        .buildDeps-rdkafka \
#        .buildDeps-pthreads \
    && rm -rf /var/cache/apk/* /var/tmp/* /tmp/* \
    && php -v \
    && composer -V \
    && php -m
