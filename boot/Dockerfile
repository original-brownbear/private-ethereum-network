FROM ubuntu:17.10

RUN apt-get update && apt-get install -y build-essential golang git net-tools iputils-ping netcat
WORKDIR /
RUN git clone https://github.com/ethereum/go-ethereum 
WORKDIR /go-ethereum
RUN make all

ADD genesis.json /ethereum/genesis.json
ADD run.sh /run.sh
ADD util.sh /util.sh

WORKDIR /go-ethereum
CMD /run.sh 
