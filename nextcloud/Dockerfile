ARG NEXTCLOUD_VERSION
FROM nextcloud:${NEXTCLOUD_VERSION}

RUN apt-get update && apt-get install -y \
    supervisor \
  && apt install -y inotify-tools \ 
  && rm -rf /var/lib/apt/lists/* \
  && mkdir /var/log/supervisord /var/run/supervisord

ENV NEXTCLOUD_UPDATE=1

COPY supervisord.conf /
COPY username.ini /
COPY nextcloud-inotifyscan /

CMD ["/usr/bin/supervisord", "-c", "/supervisord.conf"]

