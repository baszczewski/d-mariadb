FROM ubuntu:16.10
MAINTAINER Marcin Baszczewski <marcin@baszczewski.pl>

# set locale
RUN locale-gen pl_PL.UTF-8  
ENV LANG pl_PL.UTF-8  
ENV LANGUAGE pl_PL:pl  
ENV LC_ALL pl_PL.UTF-8

# set timezone
RUN echo Europe/Warsaw >/etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata

# update system
RUN DEBIAN_FRONTEND=noninteractive apt-get update -yq
RUN DEBIAN_FRONTEND=noninteractive apt-get upgrade -yq

# setup database
RUN DEBIAN_FRONTEND=noninteractive apt-get install -yq mariadb-server

# volumes
VOLUME  ["/db"]

# exposed variables
ENV MARIADB_USER admin
ENV MARIADB_PASS **Random**

# copy files
ADD prepare.sh /opt/prepare.sh
ADD setup.sh /opt/setup.sh
ADD my.cnf /tmp/my.cnf

# allow execute scripts
RUN chmod a+x /opt/prepare.sh
RUN chmod a+x /opt/setup.sh

# process prepare.sh (only once)
RUN /opt/prepare.sh

ENTRYPOINT ["/opt/setup.sh"]

# expose ports
EXPOSE 3306

# default command
CMD ["mysqld_safe"]