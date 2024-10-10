FROM debian:bullseye

COPY ./tools/staticpage.html /staticpage.html

COPY ./conf/staticpage-config.sh /staticpage-config.sh

RUN chmod +x /staticpage-config.sh && \
	mkdir -p /var/www/web

ENTRYPOINT ["./staticpage-config.sh"]
