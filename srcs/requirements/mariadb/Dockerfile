FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y mariadb-server

COPY ./conf/mdb-conf.sh /mdb-conf.sh

RUN chmod +x /mdb-conf.sh

ENTRYPOINT ["./mdb-conf.sh"]
