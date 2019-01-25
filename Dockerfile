FROM openjdk:11
MAINTAINER Masahiko Kamo <m-kamo@unext.jp>

## libfaketimeのための設定

# libfaketimeのビルドに必要なコマンドのインストール
RUN apt-get update \
 && apt-get install -y --no-install-recommends build-essential git

# libfaketimeのビルドとセットアップ
WORKDIR /
RUN git clone https://github.com/wolfcw/libfaketime.git
WORKDIR /libfaketime/src
RUN make install \
 && echo '/usr/local/lib/faketime/libfaketime.so.1' > /etc/ld.so.preload

# 不要なものを削除
RUN apt-get purge -y --auto-remove \
     -o APT::Autoremove::RecommendsImportant=false \
     -o APT::Autoremove::SuggestsImportant=false \
     build-essential git \
 && rm -rf /var/lib/apt/lists/*

# libfaketimeのための環境変数
ENV DONT_FAKE_MONOTONIC=1
ENV FAKETIME_CACHE_DURATION=1

## その他の設定

# 環境変数の設定
ENV TZ=Asia/Tokyo

# jarのコピーと起動
WORKDIR /app
COPY ./build/libs/libfaketime-*.jar /app/
ENTRYPOINT ls -1t libfaketime-*.jar | xargs -I {} java -jar {} -Djava.security.egd=file:/dev/urandom
