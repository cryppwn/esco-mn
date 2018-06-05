FROM ubuntu:xenial

EXPOSE 8017
EXPOSE 8018

VOLUME /root/.Escrow

RUN apt-get update && apt-get install -y \
	libboost-all-dev \
	libdb++-dev \
	libminiupnpc-dev \ 
	wget 

WORKDIR /esco-mn

RUN wget https://github.com/cryppwn/EscrowCoinCore_Linux/releases/download/v1.0.0.0-60025/Escrowd && chmod +x Escrowd

ENTRYPOINT ["./Escrowd"]
#ENTRYPOINT ["./Escrowd", "-printtoconsole", "-rpcallowip=127.0.0.1", "-port=8018", "-rpcport=8017"]

