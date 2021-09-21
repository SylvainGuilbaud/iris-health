ARG IMAGE=containers.intersystems.com/intersystems/irishealth-community:2021.1.0.215.0
FROM $IMAGE
USER root

RUN mkdir /data /databases && chown irisowner:irisowner /data /databases

USER irisowner
COPY ./src /tmp/src
