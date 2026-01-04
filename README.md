# Compose Recipe

This repository contains a collection of Docker Compose files for various applications and services. Each directory
corresponds to a different application, complete with its own `docker-compose.yml` file and any necessary configuration
files.

## Available Compose Files

- `kafka` - Docker Compose setup for Apache Kafka.
- `postgres` - Docker Compose setup for PostgreSQL database.
- `redis` - Docker Compose setup for Redis in-memory data structure store.
- `rabbitmq` - Docker Compose setup for RabbitMQ message broker.

## Sample Recipe

- `compose-postgres-kafka-redis.yaml` - A sample Docker Compose file that sets up a PostgreSQL database, Kafka message broker, and Redis cache together.

## LICENSE

This project is licensed under the AGPL-3.0 License. See the [LICENSE](LICENSE) file for details.
