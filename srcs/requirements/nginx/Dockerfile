FROM debian:bullseye-slim

RUN apt-get update && \
	apt-get install -y nginx openssl && \
	mkdir -p /etc/nginx/ssl /var/www/web && \
	openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key \
	-subj "/C=FR/ST=IDF/L=PARIS/O=42/OU=42/CN=mrochedy.42.fr/UID=mrochedy" && \
	chown -R www-data:www-data /var/www/web && \
	apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

ENTRYPOINT ["nginx", "-g", "daemon off;"]
