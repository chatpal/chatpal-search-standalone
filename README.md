# Chatpal-Search Standalone

_Add some description_

## Build

To build the [Docker Image]() just run

```
docker build -t chatpal/search-standalone .
```

Optional: push the image to dockerhub (after building):
```
docker push chatpal/search-standalone
```

You can find the current version also on [dockerhub](https://hub.docker.com/r/chatpal/search-standalone/).

## Run

Run the docker and forward the chatpal port `8983` so you can access it from outside the container.
```
docker run -p 8983:8983 chatpal/search-standalone
```
