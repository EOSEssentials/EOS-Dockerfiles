FROM ubuntu:17.10

RUN apt-get update \
   && apt-get install -y unattended-upgrades git sudo wget curl make \
      cmake vim net-tools ca-certificates unzip openssl

RUN apt-get install -y ninja-build clang-4.0 lldb-4.0 lld-4.0 llvm-4.0-dev libclang-4.0-dev ninja-build

RUN update-alternatives --install /usr/bin/clang clang /usr/lib/llvm-4.0/bin/clang 400 \
 && update-alternatives --install /usr/bin/clang++ clang++ /usr/lib/llvm-4.0/bin/clang++ 400

ENV CC clang
ENV CXX clang++

RUN git clone --depth 1 --single-branch --branch release_40 https://github.com/llvm-mirror/llvm.git \
   && git clone --depth 1 --single-branch --branch release_40 https://github.com/llvm-mirror/clang.git llvm/tools/clang \
   && cd llvm \
   && cmake -H. -Bbuild -GNinja -DCMAKE_INSTALL_PREFIX=/opt/wasm -DLLVM_TARGETS_TO_BUILD= -DLLVM_EXPERIMENTAL_TARGETS_TO_BUILD=WebAssembly -DCMAKE_BUILD_TYPE=Release  \
   && cmake --build build --target install \
   && cd .. && rm -rf llvm

RUN wget https://github.com/WebAssembly/binaryen/archive/1.37.33.tar.gz -O - | tar -xz \
 && cd binaryen-1.37.33 \
 && cmake -H. -Bbuild -GNinja -DCMAKE_BUILD_TYPE=Release \
 && cmake --build build --target install \
 && cd .. && rm -rf binaryen-1.37.33

RUN git clone https://github.com/eosio/eos --recursive

WORKDIR /eos
RUN git checkout dawn-2.x
RUN ./build.sh ubuntu

WORKDIR /eos/build
RUN make install

WORKDIR /eos

ENV PATH="/eos/build/install/bin:{$PATH}"

CMD ["./build/programs/eosd/eosd"]
