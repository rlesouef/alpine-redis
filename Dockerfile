FROM rlesouef/alpine-base
MAINTAINER Richard Lesouef <rlesouef@gmail.com>

# Install transmission supervisor
RUN apk --update add \
	redis
	&& rm -rf /var/cache/apk/*

RUN mkdir /data && chown redis:redis /data
VOLUME /data
WORKDIR /data

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 6379
CMD [ "redis-server" ]