FROM debian:bullseye

RUN apt-get update -y && \
	apt-get install -y wget && \
	apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/web

RUN wget https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1-mysql-en.php -O adminer.php
