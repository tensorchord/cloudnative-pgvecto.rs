ARG CNPG_TAG

FROM curlimages/curl AS download

ARG CNPG_TAG
ARG PGVECTORS_TAG
ARG TARGETARCH

WORKDIR /download
RUN pg_major=$(echo $CNPG_TAG | cut -d'.' -f1) \
    && curl --fail -o pgvectors.deb -sSL https://github.com/tensorchord/pgvecto.rs/releases/download/$PGVECTORS_TAG/vectors-pg${pg_major}_${PGVECTORS_TAG#"v"}_$TARGETARCH.deb

FROM ghcr.io/cloudnative-pg/postgresql:$CNPG_TAG

# drop to root to install packages
USER root
COPY --from=download /download/pgvectors.deb ./pgvectors.deb
RUN apt install ./pgvectors.deb

USER postgres

# From https://stackoverflow.com/a/42508925
# Note that this way of enabling the plugin only works on database init
# We should investigate alternative ways of enabling it that will always work
COPY install-pgvectors.sql /docker-entrypoint-initdb.d/
