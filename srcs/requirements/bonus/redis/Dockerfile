FROM debian:bullseye

RUN apt-get update -y && \
	apt-get install -y redis && \
	apt-get clean && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["redis-server", "--protected-mode no"]
