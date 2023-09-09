FROM ubuntu:latest

ENV DISPLAY :0

ARG JAR_FILE=./bin/colorblend-0.0.1-SNAPSHOT.jar
ARG JDK="/usr/lib/jvm/java-11-openjdk-amd64"

RUN sed 's/main$/main universe/' -i /etc/apt/sources.list && \
    apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends apt-transport-https software-properties-common && \
    add-apt-repository ppa:openjdk-r/ppa -y && \
    apt-get update && \
    apt-get install -y openjdk-11-jdk libxext-dev libxrender-dev libxtst-dev && \
    apt-get clean && \
    useradd -d /home/developer -m developer -s /bin/bash

ENV HOME /home/developer

ENV JAVA_HOME ${JDK}
ENV JDK_HOME  ${JDK}
ENV JAVA_EXE  ${JDK}/bin/java

USER developer

ADD ${JAR_FILE} app.jar

ENTRYPOINT ["java","-jar","/app.jar"]
