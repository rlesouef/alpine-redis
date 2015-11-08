# Redis on Alpine Linux
[![](https://badge.imagelayers.io/rlesouef/alpine-transmission:latest.svg)](https://imagelayers.io/?images=rlesouef/alpine-transmission:latest 'Get your own badge on imagelayers.io')

RediHow to use this image start a redis instance

    docker run --name some-redis -d redis

This image includes EXPOSE 6379 (the redis port), so standard container linking will make it automatically available to the linked containers (as the following examples illustrate).
start with persistent storage

    docker run --name some-redis -d redis redis-server --appendonly yes

If persistence is enabled, data is stored in the VOLUME /data, which can be used with --volumes-from some-volume-container or -v /docker/host/dir:/data (see docs.docker volumes).

For more about Redis Persistence, see http://redis.io/topics/persistence.
connect to it from an application

    docker run --name some-app --link some-redis:redis -d application-that-uses-redis

... or via redis-cli

    docker run -it --link some-redis:redis --rm redis sh -c 'exec redis-cli -h "$REDIS_PORT_6379_TCP_ADDR" -p "$REDIS_PORT_6379_TCP_PORT"'

Additionally, If you want to use your own redis.conf ...

You can create your own Dockerfile that adds a redis.conf from the context into /data/, like so.

    FROM redis
    COPY redis.conf /usr/local/etc/redis/redis.conf
    CMD [ "redis-server", "/usr/local/etc/redis/redis.conf" ]

Alternatively, you can specify something along the same lines with docker run options.

    docker run -v /myredis/conf/redis.conf:/usr/local/etc/redis/redis.conf --name myredis redis redis-server /usr/local/etc/redis/redis.conf

Where /myredis/conf/ is a local directory containing your redis.conf file. Using this method means that there is no need for you to have a Dockerfile for your redis container.




Redis Docker Container

Try it out
----------

Change transmission-daemon config:

    docker run -ti rlesouef/alpine-transmission vi /etc/transmission-daemon/settings.json

Create:

    mkdir -p /data/rlesouef/transmission/{downloads,incomplete}

Run the container:

    docker run -d --name transmission \
    -p 9091:9091 \
    -p 12345:12345 \
    -p 12345:12345/udp \
    -e "USERNAME=username" \
    -e "PASSWORD=password" \
    -v /data/rlesouef/transmission/downloads:/transmission/downloads \
    -v /data/rlesouef/transmission/incomplete:/transmission/incomplete \
    rlesouef/alpine-transmission

Connect to running container::

    docker exec -ti _name_container_ /bin/sh

Build it yourself
-----------------

    git clone https://github.com/rlesouef/alpine-transmission.git
    cd alpine-transmission
    docker build -t rlesouef/alpine-transmission .


```
mkdir -p /data/username/transmission/{downloads,incomplete,config}
```

Application container, don't forget to specify a password for `transmission` account and local directory for the downloads:

```
docker run -d  --name transmission \
-p 12345:12345 -p 12345:12345/udp -p 9091:9091 \
-v /data/username/transmission/downloads:/torrents/downloads \
-v /data/username/transmission/incomplete:/torrents/incomplete \
-v /data/username/transmission/config:/etc/transmission-daemon \
rlesouef/alpine-transmission

```
