FROM debian:bookworm

RUN apt-get update && apt-get install -y \
        mariadb-server \
        && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/mysqld \
    && chown -R mysql:mysql /run/mysqld


COPY conf/my.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/db-setup.sh /usr/local/bin/db-setup.sh
RUN chmod +x /usr/local/bin/db-setup.sh

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/db-setup.sh"]
