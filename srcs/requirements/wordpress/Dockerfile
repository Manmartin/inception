FROM debian:buster

EXPOSE 9000

RUN apt-get update && apt-get install -y \
	php7.3-fpm \
	php-mysql \
	mariadb-client \
	wget \
	tar

COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf
COPY ./tools/wordpress.sh .

ENTRYPOINT  ./wordpress.sh 
