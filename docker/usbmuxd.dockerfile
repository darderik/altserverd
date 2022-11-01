FROM fnndsc/ubuntu-python3:latest
WORKDIR /buildenv
RUN apt-get update && \
    apt-get install -y \
    build-essential \
    pkg-config \
    checkinstall \
    git \
    autoconf \
    automake 
RUN apt-get update && \
    apt-get install -y \
    libtool-bin \
    libudev-dev \
    udev \
    doxygen \
    cython3 \
    libssl-dev \
    openssl 

##Compile libusb
RUN git clone https://github.com/libusb/libusb
RUN cd libusb && ./autogen.sh && make && make install
##Compile libplist
RUN git clone https://github.com/libimobiledevice/libplist
RUN cd libplist && ./autogen.sh && make && make install
##Compile install libiglue
RUN git clone https://github.com/libimobiledevice/libimobiledevice-glue
RUN cd libimobiledevice-glue && ./autogen.sh && make && make install
##Compile install libusbmuxd
RUN git clone https://github.com/libimobiledevice/libusbmuxd.git
RUN cd libusbmuxd && ./autogen.sh && make && make install
##Compile libi
RUN git clone https://github.com/libimobiledevice/libimobiledevice.git
RUN cd libimobiledevice && ./autogen.sh && make && make install
##Compile install usbmuxd
RUN git clone https://github.com/libimobiledevice/usbmuxd.git
RUN cd usbmuxd && ./autogen.sh && make && make install
