FROM postgis/postgis:17-3.6-alpine

ARG PGVECTOR_VERSION=v0.8.2
ARG AGE_TAG=PG17/v1.7.0-rc0

RUN apk add --no-cache \
    bash \
    build-base \
    clang19 \
    llvm19 \
    flex \
    bison \
    git \
    curl \
    perl \
    ca-certificates \
    readline-dev \
    zlib-dev \
    linux-headers \
    coreutils \
    tar \
    postgresql17-dev

# pgvector
RUN git clone --depth 1 --branch ${PGVECTOR_VERSION} https://github.com/pgvector/pgvector.git /tmp/pgvector \
 && make -C /tmp/pgvector PG_CONFIG=/usr/bin/pg_config \
 && make -C /tmp/pgvector install PG_CONFIG=/usr/bin/pg_config \
 && rm -rf /tmp/pgvector

# Apache AGE via tarball da tag release
RUN mkdir -p /tmp/age-src \
 && curl -fL "https://github.com/apache/age/archive/refs/tags/${AGE_TAG}.tar.gz" -o /tmp/age.tar.gz \
 && tar -xzf /tmp/age.tar.gz -C /tmp/age-src --strip-components=1 \
 && make -C /tmp/age-src PG_CONFIG=/usr/bin/pg_config \
 && make -C /tmp/age-src install PG_CONFIG=/usr/bin/pg_config \
 && rm -rf /tmp/age-src /tmp/age.tar.gz

# preload do AGE
RUN echo "shared_preload_libraries = 'age'" >> /usr/local/share/postgresql/postgresql.conf.sample

COPY init-extensions.sql /docker-entrypoint-initdb.d/01-init-extensions.sql