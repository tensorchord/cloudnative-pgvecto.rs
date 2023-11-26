# cnpgvecto.rs
Container images for CNPG with the pgvecto.rs extension installed


> [!IMPORTANT]
> If you are using this image on an existing database, the postgres configuration needs to be 
> altered to enable the extension. You can do this by running:
> `psql -U postgres -c 'ALTER SYSTEM SET shared_preload_libraries = "vectors.so"'`