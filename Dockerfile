FROM jetbrains/teamcity-server:latest
LABEL maintainer="LolHens <pierrekisters@gmail.com>"


ENV TINI_VERSION 0.14.0
ENV TINI_URL https://github.com/krallin/tini/releases/download/v$TINI_VERSION/tini


RUN curl -Lo "/usr/local/bin/tini" $TINI_URL \
 && chmod +x "/usr/local/bin/tini"


ENTRYPOINT ["tini", "-g", "--"]
CMD ["/run-services.sh"]

VOLUME /data/teamcity_server/datadir
VOLUME /opt/teamcity/logs

EXPOSE 8111
