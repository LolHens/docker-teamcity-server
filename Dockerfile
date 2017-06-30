FROM jetbrains/teamcity-server:latest
MAINTAINER LolHens <pierrekisters@gmail.com>


ENV TINI_VERSION 0.14.0
ENV TINI_URL https://github.com/krallin/tini/releases/download/v$TINI_VERSION/tini


ADD ["https://raw.githubusercontent.com/LolHens/docker-tools/master/bin/cleanimage", "/usr/local/bin/"]
RUN chmod +x "/usr/local/bin/cleanimage"

RUN apt-get update \
 && apt-get dist-upgrade -y \
 && apt-get install -y \
      apt-transport-https \
      ca-certificates \
      curl \
      nano \
      unzip \
 && cleanimage

RUN curl -Lo "/usr/local/bin/tini" $TINI_URL \
 && chmod +x "/usr/local/bin/tini"

RUN cleanimage


ENTRYPOINT ["tini", "-g", "--"]
CMD ["/run-services.sh"]

VOLUME /data/teamcity_server/datadir
VOLUME /opt/teamcity/logs

EXPOSE 8111
