FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y nginx openssl

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout \
	/etc/nginx/ssl/inception.key -subj "/C=MO/ST=KH/L=KH/O=42/OU=42/CN=domain_name.fr/UID=admin_name"

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /var/www/wordpress

RUN chown -R www-data:www-data /var/www/wordpress

CMD ["nginx", "-g", "daemon off;"]
