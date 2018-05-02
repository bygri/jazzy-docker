FROM swift:4.1

RUN apt-get -qq update && apt-get install -y apt-utils \
  && echo debconf debconf/frontend select Noninteractive | debconf-set-selections \
  && apt-get -q -y install \
  tzdata \
  git \
  ruby \
  ruby-dev \
  make \
  gcc \
  libsqlite3-dev \
  clang \
  libblocksruntime0 \
  libcurl4-openssl-dev \
  && rm -r /var/lib/apt/lists/*
RUN gem install jazzy

WORKDIR /work
RUN git clone https://github.com/jpsim/SourceKitten.git . && \
    swift build -c release && \
    mv `swift build -c release --show-bin-path` /sourcekitten

WORKDIR /app

ENTRYPOINT /sourcekitten/sourcekitten doc --spm-module $MODULE > $MODULE.docs.json && jazzy -s $MODULE.docs.json
