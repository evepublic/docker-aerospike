FROM debian:8
MAINTAINER Vladimir Kozlovski <inbox@vladkozlovski.com>
ENV DEBIAN_FRONTEND noninteractive

ENV AEROSPIKE_VERSION 3.9.0.1
ENV AEROSPIKE_SHA256 4aa18ac48efa1ce57908b5816a74f2920bf34518fc7ab2cd316698421835bc69

ENV AEROSPIKE_TOOLS_VERSION 3.9.0
ENV AEROSPIKE_TOOLS_SHA256 fdd8be54c12ea4cff74740c3119642bdf220ad2e3c27ef928d73debf032a7a38

# Install Aerospike
RUN \
  apt-get update -y \
  && apt-get install -y wget logrotate ca-certificates python --no-install-recommends \

  # download aerospike server
  && wget "http://artifacts.aerospike.com/aerospike-server-community/${AEROSPIKE_VERSION}/aerospike-server-community-${AEROSPIKE_VERSION}-debian8.tgz" -O aerospike-server.tgz \
  && echo "$AEROSPIKE_SHA256 *aerospike-server.tgz" | sha256sum -c - \
  && mkdir aerospike \
  && tar xzf aerospike-server.tgz --strip-components=1 -C aerospike \
  && dpkg -i aerospike/aerospike-server-*.deb \

  # download aerospike tools
  && wget "http://artifacts.aerospike.com/aerospike-tools/${AEROSPIKE_TOOLS_VERSION}/aerospike-tools-${AEROSPIKE_TOOLS_VERSION}-debian8.tgz" -O aerospike-tools.tgz \
  && echo "$AEROSPIKE_TOOLS_SHA256 *aerospike-tools.tgz" | sha256sum -c - \
  && mkdir aerospike-tools \
  && tar xzf aerospike-tools.tgz --strip-components=1 -C aerospike-tools \
  && dpkg -i aerospike-tools/aerospike-tools-*.deb \

  # cleanup
  && apt-get purge -y --auto-remove wget ca-certificates \
  && rm -rf aerospike-server.tgz aerospike aerospike-tools.tgz aerospike-tools /var/lib/apt/lists/*


# Add the Aerospike configuration specific to this dockerfile
COPY aerospike.conf /etc/aerospike/aerospike.conf
COPY entrypoint.sh /entrypoint.sh

# Mount the Aerospike data directory
VOLUME ["/opt/aerospike/data"]
# VOLUME ["/etc/aerospike/"]


# Expose Aerospike ports
#
#   3000 – service port, for client connections
#   3001 – fabric port, for cluster communication
#   3002 – mesh port, for cluster heartbeat
#   3003 – info port
#
EXPOSE 3000 3001 3002 3003

# Execute the run script in foreground mode
ENTRYPOINT ["/entrypoint.sh"]
CMD ["asd"]
