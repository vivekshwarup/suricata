FROM centos:7

LABEL maintainer "Vivek Shwarup vivekshwarup@gmail.com"
LABEL version="Suricata 4.1.4"
LABEL description="Suricata 4.1.4 running in a docker for use with ELK."

RUN yum update -y && \
    yum clean all

# Install epel
RUN yum -y install epel-release bash libpcap iproute

RUN yum -y install GeoIP luajit libnet jansson libyaml cargo rustc && \
    yum -y erase epel-release && yum clean all && rm -rf /var/cache/yum

# Install the Suricata package
RUN ./suricata-4.1.4.0.rpm /tmp/suricata-4.1.4.0.rpm
RUN rpm -ivh /tmp/suricata-4.1.4.0.rpm
# Create Suricata User.
RUN groupadd --gid 940 suricata && \
    adduser --uid 940 --gid 940 \
    --home-dir /etc/suricata --no-create-home suricata

# Fix those perms.. big worm
RUN chown -R 940:940 /etc/suricata && \
    chown -R 940:940 /var/log/suricata

# Copy over the entry script.
ADD config/suricata.sh /usr/local/sbin/suricata.sh

RUN chmod +x /usr/local/sbin/suricata.sh && chown 940:940 /var/run/suricata

ENTRYPOINT ["/usr/local/sbin/suricata.sh"]
