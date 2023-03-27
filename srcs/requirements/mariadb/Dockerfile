FROM debian:buster

EXPOSE 3306

RUN apt-get update && apt-get install -y \
    mariadb-server

COPY ./tools/mariadb.sh mariadb.sh

ENTRYPOINT ./mariadb.sh
