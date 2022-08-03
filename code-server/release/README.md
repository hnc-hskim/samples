### password 확인
```
docker run --rm -it  -p 8080:8080/tcp code-server:latest 

8c                                                                                       g.yaml
[2022-08-03T06:35:49.305Z] info  Using user-data-dir ~/.local/share/code-server          8c
[2022-08-03T06:35:49.318Z] info  Using config file ~/.config/code-server/config.yaml     
[2022-08-03T06:35:49.319Z] info  HTTP server listening on http://0.0.0.0:8080/
[2022-08-03T06:35:49.319Z] info    - Authentication is enabled
[2022-08-03T06:35:49.319Z] info      - Using password from ~/.config/code-server/config.yaml                                                                                      aml
[2022-08-03T06:35:49.319Z] info    - Not serving HTTPS
[06:35:57] Extension host agent started.
```
### 동작 확인
```
git clone https://github.com/hnc-hskim/samples.git
```

### image build
```
sudo docker build --tag code-server:latest .
```

### image push
```
# tag 변경
$ docker tag code-server:latest "your dockerhub id"/code-server:latest

# image push
$ docker push "your dockerhub id"/code-server:latest
```

### latest
```
docker tag code-server:latest kimhaksoo/code-server:v0.17
docker push kimhaksoo/code-server:v0.17
``` 