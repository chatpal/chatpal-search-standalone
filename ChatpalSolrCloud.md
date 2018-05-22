# Running Chatpal in a dockerized Solr Cloud

This setup script shows how to run [Apache Solr][solr] in Cloud mode with a chatpal-standalone collection configured.
It is based on the docker-hub documentation on how to run [Apache Solr Cloud in Docker][2].

To have all the advantages of Docker and Cloud, please refer to the original documentation.

## Setup-Script

The following script will create a (single) [Zookeeper][zk]-Node and three Solr-Cloud Nodes in an isolated
docker network (`netzksolr`).
After that, the chatpal-configset is uploaded to Zookeeper and the collection for chatpal is created using
the command-line scripts provided by Solr.

Finally, a nginx-proxy is added as load-balancer for the solr-nodes.

```bash
# Create a separate network
docker network create --driver=bridge \
    --subnet 192.168.22.0/24 \
    --ip-range=192.168.22.128/25 \
    netzksolr

# Launch a zookeeper node for solr-cloud (for zookeeper with replication see [2])
docker run -d --name zookeeper \
    --ip=192.168.22.10 \
    --network netzksolr \
    --hostname zookeeper \
    jplock/zookeeper

# Prepare the chatpal-cloud image
docker run -t --name chatpal-search-standalone-cloud \
    chatpal/search-standalone \
    bash -c 'rm -f server/solr/chatpal/core.properties && cp server/solr/configsets/chatpal/lib/* server/solr/lib/'
docker commit chatpal-search-standalone-cloud chatpal-search-standalone-cloud
docker rm chatpal-search-standalone-cloud

# Launch 3 solr-cloud nodes
for i in 1 2 3; do
    docker run -d --name solr${i} \
        --ip=192.168.22.2${i} \
        --network netzksolr \
        -e VIRTUAL_HOST=chatpal-search.local \
        chatpal-search-standalone-cloud \
        bash -c 'solr start -f -z zookeeper:2181'
done

# upload chatpal config
docker exec -t solr1 \
    bash -c '/opt/solr/server/scripts/cloud-scripts/zkcli.sh -zkhost zookeeper:2181 -cmd upconfig -confname chatpal -confdir /opt/solr/server/solr/configsets/chatpal/conf'

# create chatpal collection
docker exec -t solr1 \
    bash -c 'solr create_collection -V -c chatpal -n chatpal -replicationFactor 3'

# provide access via proxy
docker run -d --name chatpal-proxy \
    --ip=192.168.22.9 \
    --network netzksolr \
    -p 8990:80 \
    -e DEFAULT_HOST=chatpal-search.local \
    -v /var/run/docker.sock:/tmp/docker.sock:ro \
    jwilder/nginx-proxy

echo "Go to http://localhost:8990/solr/ to check that it's up and running."
```




## Extensions

To make use of the full cloud-flexibiltiy of Solr (e.g. also running multiple Zookeeper nodes) please 
refer to the [Docker-Solr documentation][2].

## Cleanup

```bash
docker stop chatpal-proxy solr3 solr2 solr1 zookeeper
docker rm chatpal-proxy solr3 solr2 solr1 zookeeper
docker network rm netzksolr
docker rmi chatpal-search-standalone-cloud
```

[1]:https://github.com/docker-solr/docker-solr/blob/master/Docker-FAQ.md#can-i-run-zookeeper-and-solr-clusters-under-docker
[2]:https://github.com/docker-solr/docker-solr/blob/master/docs/docker-networking.md
[zk]:https://zookeeper.apache.org
[solr]:https://lucene.apache.org/solr/

