FROM debian:jessie

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5
RUN echo "deb http://repo.mongodb.org/apt/debian jessie/mongodb-org/3.6 main" | tee /etc/apt/sources.list.d/mongodb-org-3.6.list
RUN apt-get update
RUN apt-get install -y mongodb-org-tools

RUN echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ jessie main" | tee /etc/apt/sources.list.d/azure-cli.list
RUN apt-key adv --keyserver packages.microsoft.com --recv-keys 52E16F86FEE04B979B07E28DB02C46DF417A0893
RUN apt-get install -y apt-transport-https
RUN apt-get update
RUN apt-get install -y azure-cli

RUN apt-get install -y dos2unix

COPY ./run.sh ./home/src/run.sh

RUN dos2unix /home/src/run.sh

RUN apt-get --purge remove -y dos2unix

CMD bash /home/src/run.sh