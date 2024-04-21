FROM ubuntu:20.04
WORKDIR /buildenv
RUN apt-get update && apt-get install software-properties-common -y && add-apt-repository ppa:deadsnakes/ppa -y
RUN apt-get update && apt-get install -y build-essential \
    pkg-config \
    checkinstall \
    git \
    autoconf \
    automake  \
    libtool-bin \
    libudev-dev \
    udev \
    doxygen \
    cython3 \
    libssl-dev \
    openssl \
    python3.9 \
    python3.9-dev \
    python2.7-dev \
    python2.7 \
    python3-dev \
    python-dev


##Compile libusb
RUN git clone https://github.com/libusb/libusb --branch v1.0.26
RUN cd libusb && ./autogen.sh && make && make install
##Compile libplist
RUN git clone https://github.com/libimobiledevice/libplist --branch 2.3.0
RUN cd libplist && ./autogen.sh && make && make install
##Compile install libiglue
RUN git clone https://github.com/libimobiledevice/libimobiledevice-glue --branch 1.2.0
RUN cd libimobiledevice-glue && ./autogen.sh && make && make install
##Compile install libusbmuxd
RUN git clone https://github.com/libimobiledevice/libusbmuxd.git --branch 2.0.2
RUN cd libusbmuxd && ./autogen.sh && make && make install
##Compile libi
RUN git clone https://github.com/libimobiledevice/libimobiledevice.git
RUN cd libimobiledevice && git checkout 860ffb707af3af94467d2ece4ad258dda957c6cd && ./autogen.sh && make && make install
##Compile install usbmuxd
RUN git clone https://github.com/libimobiledevice/usbmuxd.git
RUN cd usbmuxd && ./autogen.sh && make && make install
