# libfaketime

アプリケーションのビルド。
```
./gradlew build
```

イメージの作成。
```
docker build -t libfaketime .
```

コンテナ起動。
```
docker run --rm --name libfaketime -d -p8080:8080 libfaketime
```

起動したままシステム時刻を変更できる。
```
docker exec libfaketime sh -c "echo '@2000-01-01 09:00:00' > /etc/faketimerc"
curl localhost:8080/date; echo

docker exec libfaketime sh -c "echo '+2d' > /etc/faketimerc"
curl localhost:8080/date; echo

docker exec libfaketime sh -c "echo '-5d' > /etc/faketimerc"
curl localhost:8080/date; echo

docker exec libfaketime sh -c "rm /etc/faketimerc"
curl localhost:8080/date; echo
```

コンテナ終了。
```
docker stop libfaketime
```
