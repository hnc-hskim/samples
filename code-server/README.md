$ git config --global user.name ""
$ git config --global user.email  ""

```
# tag 변경
$ docker tag code-server:latest kimhaksoo/code-server:latest

# image push
$ docker push kimhaksoo/code-server:latest

# 실행 확인
docker run -it -p 8080:8080 --name code -e PASSWORD="0000" code-server:latest
```