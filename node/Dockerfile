FROM ubuntu:17.10

RUN apt-get update && apt-get install -y build-essential golang git
WORKDIR /
RUN git clone https://github.com/ethereum/go-ethereum 
WORKDIR /go-ethereum
RUN make all
