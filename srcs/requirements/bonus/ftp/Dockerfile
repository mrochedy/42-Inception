FROM debian:bullseye

RUN apt-get update -y && \
	apt-get install -y vsftpd && \
	apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./conf/ /

RUN chmod +x /ftp-config.sh && \
	mkdir -p /var/run/vsftpd/empty

ENTRYPOINT ["bash", "/ftp-config.sh"]
