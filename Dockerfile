ARG SOLR_VERSION=7.2-alpine
FROM solr:$SOLR_VERSION

LABEL maintainer=jakob.frank@redlink.co

# Deploy the chatpal configset
#ADD --chown=solr:solr \
ADD \
    solr-conf \
    /opt/solr/server/solr/configsets

# Fetch additional solr-dependencies
#ADD --chown=solr:solr \
ADD \
    https://oss.sonatype.org/content/repositories/snapshots/io/redlink/solr/compound-word-filter/1.0.0-SNAPSHOT/compound-word-filter-1.0.0-20180304.180502-3.jar \
    https://repo.maven.apache.org/maven2/org/apache/lucene/lucene-analyzers-stempel/7.2.1/lucene-analyzers-stempel-7.2.1.jar \
    https://repo.maven.apache.org/maven2/org/apache/lucene/lucene-analyzers-morfologik/7.2.1/lucene-analyzers-morfologik-7.2.1.jar \
    https://repo.maven.apache.org/maven2/org/carrot2/morfologik-stemming/2.1.1/morfologik-stemming-2.1.1.jar \
    https://repo.maven.apache.org/maven2/org/carrot2/morfologik-fsa/2.1.1/morfologik-fsa-2.1.1.jar \
    https://repo.maven.apache.org/maven2/ua/net/nlp/morfologik-ukrainian-search/3.9.0/morfologik-ukrainian-search-3.9.0.jar \
    https://repo.redlink.io/mvn/content/groups/public/io/chatpal/chatpal-api/solr-ext/0.0.1-SNAPSHOT/solr-ext-0.0.1-20180315.082939-4.jar \
    /opt/solr/server/solr/configsets/chatpal/lib/

USER root
# docker-hub does not yet support the --chown-flag
RUN chown -R solr:solr /opt/solr/server/solr/configsets/chatpal
# create data-dir
#RUN mkdir -p /data/chatpal && chown -R solr:solr /data/chatpal
USER solr

# Create the chatpal solr core
RUN mkdir -p /opt/solr/server/solr/chatpal/data && \
    echo -e "name=chatpal\nconfigSet=chatpal\n" >/opt/solr/server/solr/chatpal/core.properties;

# Expose Solr-Data dir
VOLUME ['/opt/solr/server/solr/chatpal']
