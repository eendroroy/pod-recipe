#!/usr/bin/env bash

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <postgres_version> <postgres_password> -n [container_name] -p [port] -u [username]"
    exit 1
fi

# parse arguments
VERSION=$1
PASSWORD=$2
USERNAME="postgres"
PORT=5432
CONTAINER_NAME="postgres_${VERSION}"
shift 2
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -n)
            CONTAINER_NAME="$2"
            shift 2
            ;;
        -p)
            PORT="$2"
            shift 2
            ;;
        -u)
            USERNAME="$2"
            shift 2
            ;;
        *)
            echo "Unknown parameter passed: $1"
            echo "Usage: $0 <postgres_version> <postgres_password> -n [container_name] -p [port] -u [username]"
            exit 1
            ;;
    esac
done


# create data directory if it doesn't exist
echo "Data will be stored in: ${SCRIPT_DIR}/mounts/postgres/pg_data/${VERSION}"
echo "Creating data directory for PostgreSQL ${VERSION}..."
mkdir -p "${SCRIPT_DIR}/mounts/postgres/pg_data/${VERSION}"

echo "Starting PostgreSQL ${VERSION} container named '${CONTAINER_NAME}'..."
echo "User:     ${USERNAME}"
echo "Password: ${PASSWORD}"
echo "Port:     ${PORT}"

# cehck if container with the same name is already running
if podman ps --format "{{.Names}}" | grep -q "^${CONTAINER_NAME}$"; then
    echo "A container named '${CONTAINER_NAME}' is already running. Please choose a different name."
    exit 1
fi

podman run -d --name "${CONTAINER_NAME}" \
  -e POSTGRES_PASSWORD="${PASSWORD}" \
  -e POSTGRES_USERNAME="${USERNAME}" \
  -v "${SCRIPT_DIR}/mounts/postgres/pg_data/${VERSION}":/var/lib/postgresql/data:Z \
  -p ${PORT}:5432 \
  postgres:${VERSION}