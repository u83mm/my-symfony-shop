FROM mariadb:latest

# Set working directory
WORKDIR /var/lib/mysql

ARG USER_ID=1000
ARG GROUP_ID=1000

# Arguments for the system user and group
ARG SYSTEM_USER="mario"
ARG SYSTEM_GROUP="mario"

# Asigna grupo y usuario en contenedor para no tener que estar cambiando propietario a los archivos creados desde el contenedor
RUN addgroup --gid ${GROUP_ID} ${SYSTEM_GROUP}
RUN adduser --disabled-password --gecos '' --uid ${USER_ID} --gid ${GROUP_ID} ${SYSTEM_USER}
USER 1000

COPY my_database.sql /var/lib/mysql
