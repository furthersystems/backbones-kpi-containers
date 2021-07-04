FROM docker.elastic.co/elasticsearch/elasticsearch:7.13.2
RUN elasticsearch-plugin install analysis-kuromoji
COPY elasticsearch.yml /usr/share/elasticsearch/config/
COPY log4j2.properties /usr/share/elasticsearch/config/
COPY sysctl.conf /etc/sysctl.d/
RUN dnf -y install jq nodejs && npm install elasticdump@6.72.0 -g
