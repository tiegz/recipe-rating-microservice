
### Running locally

`bundle exec puma config.ru --log-requests`

### Running with Dockerfile

`docker run -p 9292:9292 -it $(docker build -q .)`