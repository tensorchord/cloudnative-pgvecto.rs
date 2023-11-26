ARG PG_TAG

FROM rust:1.74.0-bullseye as build

ARG PG_TAG
ARG PGVECTORS_TAG=v0.1.10

RUN apt update && apt install -y build-essential libpq-dev libssl-dev pkg-config gcc libreadline-dev flex bison libxml2-dev libxslt-dev libxml2-utils xsltproc zlib1g-dev ccache clang git

WORKDIR /build
RUN git clone --depth 1 --branch $PGVECTORS_TAG https://github.com/tensorchord/pgvecto.rs.git .
RUN cargo install cargo-pgrx --version $(grep '^pgrx ' Cargo.toml | awk -F'\"' '{print $2}')
RUN cargo pgrx init
RUN cargo pgrx package

# pull pgvectors
# build and package pgvectors

# FROM ghcr.io/cloudnative-pg/postgresql:$PG_TAG

# copy pgvectors package
# build pgvectors
