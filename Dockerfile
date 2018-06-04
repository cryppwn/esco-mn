FROM ubuntu

EXPOSE 8017
EXPOSE 8018

#VOLUME /root/.Escrow/Escrow.conf

RUN apt-get update && apt-get install -y \
	libboost-all-dev \
	libdb++-dev \
	libminiupnpc-dev 

WORKDIR /esco-mn

COPY bin/Escrowd .

#ENTRYPOINT ["./Escrowd", "-daemon"]
ENTRYPOINT ["./Escrowd", "-printtoconsole"]
#ENTRYPOINT ["./Escrowd", "-printtoconsole", "-rpcallowip=127.0.0.1", "-port=8018", "-rpcport=8017"]

