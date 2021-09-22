ARG IMAGE=containers.intersystems.com/intersystems/irishealth-community:2021.1.0.215.0
FROM $IMAGE
USER root
RUN mkdir /src /data /databases \
 && chown irisowner:irisowner /src /data /databases
USER irisowner