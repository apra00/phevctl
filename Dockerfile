FROM raspbian/bullseye:11
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get -y update && apt-get upgrade -y && apt-get -y install build-essential cmake git
WORKDIR /src
RUN git clone https://github.com/apra00/msg-core && git clone https://github.com/apra00/phevcore.git && git clone https://github.com/apra00/cJSON.git
RUN cd /src/cJSON && mkdir build && cd build && cmake .. && make && make install
RUN cd /src/msg-core && mkdir build && cd build && cmake .. && make && make install
RUN cd /src/phevcore && mkdir build && cd build && cmake .. && make && make install
COPY . /src/phevctl
WORKDIR /src/phevctl
RUN mkdir -p build && cd build && cmake .. && make
ENTRYPOINT ["/src/phevctl/build/phevctl"]
CMD []

