FROM debian:buster

EXPOSE 443

RUN apt-get update && apt-get install -y \
	nginx \
	openssl

RUN openssl req -x509 -nodes -days 365 -subj "/ST=Spain/L=Madrid/OU=42Madrid/CN=manmarti" -newkey rsa:2048 -out /etc/ssl/ssl.crt -keyout /etc/ssl/ssl.key

COPY conf/default /etc/nginx/sites-available/default

ENTRYPOINT nginx -g 'daemon off;'
