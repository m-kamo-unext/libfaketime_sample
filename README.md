# libfaketime

libfaketimeを使ってプロセスから見えるシステム時刻を変更するサンプル。

HTTPで`LocalDateTime.now()`を返すだけのSpring Bootアプリケーションを，
libfaketimeを仕込んだdockerコンテナ上で動かす。

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
