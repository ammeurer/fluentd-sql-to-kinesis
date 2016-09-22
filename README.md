# Fluentd Postgresql to Kinesis Stream Docker Image

## Run locally
 * Start up Docker on your machine
 * Fill in the database secrets and AWS credentials in the config file and Dockerfile
 * Navigate to project directory and build image: `docker build -t producer:latest ./`
 * Run the Docker container: `docker run producer:latest`

## Resources
 * [How to create a fluentd docker container](https://github.com/fluent/fluentd-docker-image)
 * [fluent-plugin-sql](https://github.com/fluent/fluent-plugin-sql)
 * [aws-fluent-plugin-kinesis](https://github.com/awslabs/aws-fluent-plugin-kinesis)
 * [How to install Postgresql for dev on Alpine base image](http://nickjanetakis.com/blog/alpine-based-docker-images-make-a-difference-in-real-world-apps)
 * [How to write Fluentd configuration file](http://docs.fluentd.org/articles/config-file)
