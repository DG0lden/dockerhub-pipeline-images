FROM ubuntu:18.04

LABEL maintainer="adorsys GmbH & Co. KG" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.vendor="adorsys GmbH & Co. KG" \
      org.label-schema.name="" \
      org.label-schema.description="" \
      org.label-schema.usage="" \
      org.label-schema.license="" \
      org.label-schema.build-date=""

ARG PANDOC_VERSION=2.7.3
ARG PLANTUML_VERSION=1.2019.7

ENV TZ=Europe/Berlin \
    JAVA_OPTS="-Xmx128m" \
    DEBIAN_FRONTEND=noninteractive \
    HOME=/tmp

COPY root /

RUN apt-get update && apt-get upgrade -y \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
    && apt-get install -y make rsync openjdk-11-jdk-headless curl graphviz ruby fontconfig graphviz jq \
    && mkdir /usr/local/share/plantuml \
    && curl -sSf -L https://sourceforge.net/projects/plantuml/files/plantuml.${PLANTUML_VERSION}.jar/download --output /usr/local/share/plantuml/plantuml.jar \
    && curl -sSf -L https://github.com/jgm/pandoc/releases/download/${PANDOC_VERSION}/pandoc-${PANDOC_VERSION}-1-amd64.deb --output /tmp/pandoc-amd64.deb \
    && dpkg -i /tmp/pandoc-amd64.deb && rm /tmp/pandoc-amd64.deb \
    && gem install --no-document asciidoctor \
    && apt-get clean all

USER 1001
