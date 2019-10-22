# Use the EPICS base image
FROM kedokudo/synapps:latest
LABEL version="0.0.2" \
      maintainer="kedokudo <chenzhang8722@gmail.com>" \
      lastupdate="2019-10-22"
USER  root

# PV prefix
ENV   PREFIX="6iddSIM1:"
EXPOSE 5064 5065

RUN apt-get update  -y && apt-get upgrade -y && \
    apt-get install -y procps \
    && rm -rf /var/lib/apt/lists/*


# build the sim scalers and motors
WORKDIR /opt/synApps/support/xxx-R6-1
RUN     make rebuild

WORKDIR /opt/synApps/support/xxx-R6-1/iocBoot/iocxxx/softioc
ENTRYPOINT [ "./run"]

# --- DEV ---
# docker build -t kedokudo/ioc6iddsimmtr:latest .    
# docker run -it --rm -e PREFIX='test1:' kedokudo/ioc6iddsimmtr:latest /bin/bash                                                                     
#./xxx.sh start