FROM ubuntu:jammy

COPY ./settings.sh /opt
RUN /usr/bin/bash /opt/settings.sh && rm -rf /opt/settings.sh

COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

COPY ./chrootpw.sh /
RUN chmod +x /chrootpw.sh

ENTRYPOINT /docker-entrypoint.sh
