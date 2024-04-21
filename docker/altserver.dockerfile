FROM ubuntu

# Preparing packages
RUN apt update -y && apt install -y zsh git curl wget g++ clang libboost-all-dev libboost-dev cmake make sudo bash vim libssl-dev zlib1g-dev ninja-build

RUN mkdir /buildenv
WORKDIR /buildenv

# Build corecrypto
#RUN curl -JO 'https://developer.apple.com/file/?file=security&agree=Yes' -H 'Referer: https://developer.apple.com/security/' && unzip corecrypto.zip
#WORKDIR /buildenv/corecrypto-2023

# Merge corecrypto and needed scripts
RUN git clone https://github.com/altserver-for-android/corecrypto/ corecrypto
WORKDIR /buildenv/corecrypto
RUN sed -i '1d' CMakeLists.txt
RUN git clone https://github.com/StableCoder/cmake-scripts scripts__temp
RUN mkdir scripts
RUN cp -R ./scripts__temp/* ./scripts

RUN mkdir build && cd build && CC=clang CXX=clang++ cmake ..
WORKDIR /buildenv/corecrypto/build
RUN make
RUN make install

# Build c++ rest sdk
WORKDIR /buildenv/cpprestsdk
RUN git clone --recursive https://github.com/microsoft/cpprestsdk .; 
RUN sed -i 's|-Wcast-align||' "./Release/CMakeLists.txt"
RUN mkdir build; cd build; cmake -DBUILD_SHARED_LIBS=0 ..; make; make install

# Build libzip
WORKDIR /buildenv
RUN git clone https://github.com/nih-at/libzip && cd libzip; mkdir build; cd build; cmake -DBUILD_SHARED_LIBS=0 ..; make ; make install

# Build altserver
WORKDIR /buildenv/altserver
RUN git clone --recursive https://github.com/NyaMisty/AltServer-Linux
RUN apt install uuid-dev -y
RUN cd AltServer-Linux && make




# RUN mkdir build && make && mv ./AltServer-* ./altserver
