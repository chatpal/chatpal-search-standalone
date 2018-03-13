# Chatpal-Search Standalone

_Add some description_

## Run

To launch the backend just run

```
docker run -d --name chatpal-search -p 8983:8983 chatpal/search-standalone
```

and point the chatpal-search provider to the following url: `http://YOUR-DOCKER-IP:8983/solr/chatpal`

## Build

To build the [Docker Image](https://www.docker.com/) just run

```
docker build -t chatpal/search-standalone .
```

Optional: push the image to dockerhub (after building):

```
docker push chatpal/search-standalone
```

You can find the current version also on [dockerhub](https://hub.docker.com/r/chatpal/search-standalone/).
