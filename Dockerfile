FROM alpine:3.20

RUN apk add --no-cache bash coreutils tar shadow

ARG APP_UID=1000
ARG APP_GID=1000

RUN groupadd -g ${APP_GID} app && \
    useradd -u ${APP_UID} -g app -m app && \
    mkdir -p /app/scripts /app/logs && \
    chown -R app:app /app

WORKDIR /app

COPY --chown=app:app scripts/backup.sh /app/scripts/backup.sh

USER app

ENTRYPOINT ["bash", "/app/scripts/backup.sh"]
