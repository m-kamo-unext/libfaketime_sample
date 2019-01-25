# libfaketime_sample

## 概要

libfaketimeを使ってプロセスから見えるシステム時刻を変更するサンプル。

`LocalDateTime.now()`の結果を返すだけのSpring Boot Webアプリケーションを，
libfaketimeを仕込んだdockerコンテナ上で動かす。

## 動作要件
- Docker
  - Docker Desktop for Windows 2.0.0.2で動作確認
- JDK
  - OpenJDK 11で動作確認

## 使用方法
アプリケーションのビルドとイメージの作成。
```
./gradlew build
docker build -t libfaketime .
```

コンテナ起動。
```
docker run --rm --name libfaketime -d -p8080:8080 libfaketime
```

起動したままシステム時刻を変更できる。
```
curl localhost:8080; echo

docker exec libfaketime sh -c "echo '@2000-01-01 09:00:00' > /etc/faketimerc"
curl localhost:8080; echo

docker exec libfaketime sh -c "echo '+2d' > /etc/faketimerc"
curl localhost:8080; echo

docker exec libfaketime sh -c "echo '-5d' > /etc/faketimerc"
curl localhost:8080; echo

docker exec libfaketime sh -c "rm /etc/faketimerc"
curl localhost:8080; echo
```

コンテナ終了。
```
docker stop libfaketime
```
