FROM gliderlabs/alpine:3.3

# Install transmission supervisor
RUN apk --update add \
	bash nano \
	redis \
	&& rm -rf /var/cache/apk/*

RUN mkdir /data
RUN chown redis:redis /data
VOLUME /data
WORKDIR /data

COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 6379
CMD [ "redis-server" ]
