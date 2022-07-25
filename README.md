# samples

[monolithic architecture](https://github.com/zachgoll/monolithic-architecture-example-app)  
[layered architecture](https://github.com/zachgoll/layered-architecture-example-app)  
[microservices architecture](https://github.com/zachgoll/microservices-architecture-example)  



# clone repository
```
$ git clone https://github.com/zachgoll/monolithic-architecture-example-app
$ git clone https://github.com/zachgoll/layered-architecture-example-app.git 
$ git clone https://github.com/zachgoll/microservices-architecture-example.git

## mongodb docker
https://github.com/duluca/mongo-docker.git
```

### git submodule 추가(helm chart export)
```
git submodule add -b main https://github.com/hnc-hskim/helm-charts.git packages
```

## git submodule 삭제
```
$ git submodule deinit -f packages

$ rm -rf .git/modules/packages

$ git rm -f packages
```