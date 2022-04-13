# Chatpal-Search Standalone

_Rocketchat + Chatpal = Easy and efficient digital business communication._

The standalone version of Chatpal allows you to run the server-backend on your own
server - having all the data, requests and resources under your control.

If you are looking for a fast and easy-to-use solution, please check out
[chatpal.io](https://chatpal.io/).

## Run

To launch the backend just run

```shell
docker run -d --name chatpal-search -p 8983:8983 chatpal/search-standalone
```

and point the chatpal-search provider to the following url: `http://YOUR-DOCKER-IP:8983/solr/chatpal`

### Solr Cloud

If you need to run Chatpal-Search in a Solr-Cloud environment, please have a look into
[Running Chatpal in a dockerized Solr Cloud](ChatpalSolrCloud.md). It contains some
useful hints about the `docker-compose.yaml` in this repo.

### Security-Advisory

#### Log4Shell (CVE-2021-44228)

Starting with `v0.5`, this image is based on a Solr-Version with the
[mitigation-strategy](https://solr.apache.org/news.html#apache-solr-affected-by-apache-log4j-cve-2021-44228)
build in. If you are unable to update to this version, start the container with the following parameter
`-e "SOLR_OPTS=-Dlog4j2.formatMsgNoLookups=true"`

## Build

To build the [Docker Image](https://www.docker.com/) just run

```shell
docker build -t chatpal/search-standalone .
```

Optional: push the image to dockerhub (after building):

```shell
docker push chatpal/search-standalone
```

You can find the current version also on [dockerhub](https://hub.docker.com/r/chatpal/search-standalone/).

