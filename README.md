# Chatpal-Search Standalone

_Rocketchat + Chatpal = Easy and efficient digital business communication._

The standalone version of Chatpal allows you to run the server-backend on your own
server - having all the data, requests and resources under your control.

If you are looking for a fast and easy-to-use solution, please check out
[chatpal.io](https://chatpal.io/).

## Run

To launch the backend just run

```
docker run -d --name chatpal-search -p 8983:8983 chatpal/search-standalone
```

and point the chatpal-search provider to the following url: `http://YOUR-DOCKER-IP:8983/solr/chatpal`

### Solr Cloud

If you need to run Chatpal-Search in a Solr-Cloud environment, please have a look into
[Running Chatpal in a dockerized Solr Cloud](ChatpalSolrCloud.md).

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
