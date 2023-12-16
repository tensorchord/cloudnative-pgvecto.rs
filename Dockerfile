# syntax=docker/dockerfile-upstream:master
ARG CNPG_TAG

FROM ghcr.io/cloudnative-pg/postgresql:$CNPG_TAG

ARG CNPG_TAG
ARG PGVECTORS_TAG
ARG TARGETARCH

# drop to root to install packages
USER root
ADD https://github.com/tensorchord/pgvecto.rs/releases/download/$PGVECTORS_TAG/vectors-pg${CNPG_TAG%.*}_${PGVECTORS_TAG#"v"}_$TARGETARCH.deb ./pgvectors.deb
RUN apt install ./pgvectors.deb

USER postgres

# From https://stackoverflow.com/a/42508925
# Note that this way of enabling the plugin only works on database init
# We should investigate alternative ways of enabling it that will always work
COPY install-pgvectors.sql /docker-entrypoint-initdb.d/
