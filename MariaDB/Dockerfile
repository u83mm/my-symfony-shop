FROM mariadb:latest

ARG USER_ID=1000
ARG GROUP_ID=1000

# Arguments for the system user and group
ARG SYSTEM_USER="mario"
ARG SYSTEM_GROUP="mario"

# Asigna grupo y usuario en contenedor para no tener que estar cambiando propietario a los archivos creados desde el contenedor
RUN groupadd --gid ${GROUP_ID} mario && \
    useradd --uid ${USER_ID} --gid ${GROUP_ID} -m mario

USER ${USER_ID}

# Set working directory
WORKDIR /var/lib/mysql
