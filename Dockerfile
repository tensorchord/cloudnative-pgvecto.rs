ARG PG_MAJOR=14

FROM ghcr.io/cloudnative-pg/postgresql:$PG_MAJOR

ARG PG_MAJOR
ARG PGVECTORS_TAG
ARG ARCH=x86_64

# drop to root to install packages
USER root
ADD https://github.com/tensorchord/pgvecto.rs/releases/download/$PGVECTORS_TAG/vectors-pg$PG_MAJOR-$PGVECTORS_TAG-$ARCH-unknown-linux-gnu.deb ./pgvectors.deb
RUN apt install ./pgvectors.deb

USER postgres

# From https://stackoverflow.com/a/42508925
# Note that this way of enabling the plugin only works on database init
# We should investigate alternative ways of enabling it that will always work
COPY install-pgvectors.sql /docker-entrypoint-initdb.d/