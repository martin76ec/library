FROM mysql:latest

# Allow root with no password from any host
ENV MYSQL_ROOT_PASSWORD="password"
ENV MYSQL_ALLOW_EMPTY_PASSWORD=true

# Copy the init.sql file
COPY init.sql /docker-entrypoint-initdb.d/

# Run the init.sql file
CMD ["mysqld", "--init-file=/docker-entrypoint-initdb.d/init.sql"]
