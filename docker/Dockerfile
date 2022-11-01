FROM usbmuxd
##AltServer part
RUN apt-get update -yy && \
    apt-get install -yy \
    libnss-mdns \
    iputils-ping dnsutils ideviceinstaller libavahi-client-dev libavahi-compat-libdnssd-dev libavahi-client-dev  avahi-discover avahi-utils 
#avahi-daemon 
RUN apt-get install -y curl usbutils iproute2 
#RUN sed -i 's/.*enable-dbus=.*/enable-dbus=no/' /etc/avahi/avahi-daemon.conf
RUN mkdir /app
WORKDIR /app
COPY ./run.sh .
ENTRYPOINT ["/bin/bash"]