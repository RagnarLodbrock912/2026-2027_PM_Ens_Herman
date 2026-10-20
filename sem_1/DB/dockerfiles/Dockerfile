FROM mysql:8.0-debian

# The official MySQL entrypoint executes this file once for a new data volume.
COPY init.sql /docker-entrypoint-initdb.d/01-init.sql
