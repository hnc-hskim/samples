## docker 실행시 패스워드 확인
```
~/.config/code-server/config.yaml
```

```
docker run --rm -it  -p 8080:8080/tcp code-server:latest 

[2022-08-03T01:46:46.892Z] info  Wrote default config file to ~/.config/code-server/config.yaml       
[2022-08-03T01:46:47.162Z] info  code-server 3.11.0 4e8cd09ef0412dfc7b148b7639a692e20e4fd6dd
[2022-08-03T01:46:47.163Z] info  Using user-data-dir ~/.local/share/code-server
[2022-08-03T01:46:47.173Z] info  Using config file ~/.config/code-server/config.yaml
[2022-08-03T01:46:47.173Z] info  HTTP server listening on http://0.0.0.0:8080
[2022-08-03T01:46:47.173Z] info    - Authentication is enabled
[2022-08-03T01:46:47.173Z] info      - Using password from $PASSWORD
[2022-08-03T01:46:47.173Z] info    - Not serving HTTPS
```

### docker 테스트
```
docker run hello-world
```

### code-server github
```
git clone https://github.com/coder/code-server.git

# submodule도 clone
git clone --recurse-submodules https://github.com/coder/code-server.git
```

### docker build
```
$ docker build -t code-server:v0.1 -f Dockerfile .
```

### docker run
``` 
docker run -it -p 8080:8080 --name code -e PASSWORD="0000" code-server:latest 

# docker:dind는 도커컨테이너 안에 docker를 사용하기 위해 사용한다. 
docker run --privileged --cap-add=NET_ADMIN -it -p 8080:8080 --name code -e PASSWORD="0000" code-server:latest docker:dind

```

- in kubernetes manifest
```
securityContext: 
  privileged: true
  capabilities:
    add: ["NET_ADMIN"]
```

### image push
```
# tag 변경
$ docker tag code-server:latest "your dockerhub id"/code-server:latest

# image push
$ docker push "your dockerhub id"/code-server:latest

docker tag code-server:latest kimhaksoo/code-server:v0.15
docker push kimhaksoo/code-server:v0.15
``` 

---
https://kmaster.tistory.com/39?category=925859
https://hub.docker.com/r/linuxserver/code-server

## build 및 버전 관리
```
# Chart.yaml
version: 3.0.26

# deploy.sh
mv code-server-3.0.26.tgz ../../packages/code-server/
```

## Code Server Helm 설치
```
# git clone https://github.com/coder/code-server
# cd code-server
# kubectl create ns code-server
# helm upgrade --install code-server ci/helm-chart --set persistence.enabled=true -n code-server
```

## Plug-In 추가 설치
```
# cd ci/helm-chart
# ls
Chart.yaml  templates  values.yaml

# values.yaml 수정

# helm upgrade --install code-server .  -n code-server -f values.yaml 

helm upgrade --install code-server .  -n hskim -f values.yaml 
```

## Helm 삭제
```
$ helm delete code-server -n code-server
release "code-server" uninstalled
```

## 차트 문법 검사
```
$ helm lint <Chart.yaml path>
```

## templates 검사
```
$ helm template <Chart.yaml path>
```

## chart 시험 설치 
```
$ helm install <release name> <Chart.yaml path> --debug --dry-run

helm install code-server ./helm-chart --debug --dry-run

helm install code-server . --debug --dry-run

helm template code-server . --dry-run --debug -n hskim
```

## 디버깅 방법
- code-server 디렉토리에서 실행
- helm upgrade -i code-server ./helm-chart --dry-run --debug

```
$ helm upgrade -i code-server ./helm-chart --dry-run --debug
history.go:56: [debug] getting history for release code-server
Release "code-server" does not exist. Installing it now.
install.go:178: [debug] Original chart version: ""
install.go:195: [debug] CHART PATH: C:\work2022\git\hnc-hskim\samples\code-server\helm-chart

NAME: code-server
LAST DEPLOYED: Tue Jul 26 12:32:12 2022
NAMESPACE: default
STATUS: pending-install
REVISION: 1
USER-SUPPLIED VALUES:
{}

COMPUTED VALUES:
CodeServerUrl: null
affinity: {}
extraArgs: []
extraConfigmapMounts: []
extraContainers: ""
extraSecretMounts: []
extraVars: []
extraVolumeMounts: []
fullnameOverride: ""
hostnameOverride: ""
image:
  pullPolicy: Always
  repository: linuxserver/code-server
imagePullSecrets: []
ingress:
  enabled: false
  ingressClassName: ""
nameOverride: ""
nodeSelector: {}
password: code321
persistence:
  accessMode: ReadWriteOnce
  annotations: {}
  enabled: true
  size: 5Gi
podAnnotations: {}
podSecurityContext: {}
priorityClassName: ""
replicaCount: 1
resources: {}
securityContext:
  enabled: true
  runAsUser: 0
service:
  port: 80
  type: ClusterIP
serviceAccount:
  annotations: {}
  create: true
  name: ""
tolerations: []
virtualservice:
  enabled: false
  gateways: istio-system/apps-dns-ingressgateway
volumePermissions:
  enabled: true
  securityContext:
    runAsUser: 0

HOOKS:
---
# Source: code-server/templates/secrets.yaml
apiVersion: v1
kind: Secret
metadata:
  name: code-server
  namespace: default
  annotations:
    "helm.sh/hook": "pre-install"
  labels:
    app.kubernetes.io/name: code-server
    helm.sh/chart: code-server-3.0.8
    app.kubernetes.io/instance: code-server
    app.kubernetes.io/managed-by: Helm
type: Opaque
data:

  password: "Y29kZTMyMQ=="
---
# Source: code-server/templates/tests/test-connection.yaml
apiVersion: v1
kind: Pod
metadata:
  name: "code-server-test-connection"
  labels:
    app.kubernetes.io/name: code-server
    helm.sh/chart: code-server-3.0.8
    app.kubernetes.io/instance: code-server
    app.kubernetes.io/managed-by: Helm
  annotations:
    "helm.sh/hook": test-success
spec:
  containers:
    - name: wget
      image: busybox
      command: ['wget']
      args:  ['code-server:80']
  restartPolicy: Never
MANIFEST:
---
# Source: code-server/templates/serviceaccount.yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  labels:
    app.kubernetes.io/name: code-server
    helm.sh/chart: code-server-3.0.8
    app.kubernetes.io/instance: code-server
    app.kubernetes.io/managed-by: Helm
  name: code-server
  namespace: default
---
# Source: code-server/templates/pvc.yaml
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: code-server
  namespace: default
  labels:
    app.kubernetes.io/name: code-server
    helm.sh/chart: code-server-3.0.8
    app.kubernetes.io/instance: code-server
    app.kubernetes.io/managed-by: Helm
spec:
  accessModes:
    - "ReadWriteOnce"
  resources:
    requests:
      storage: "5Gi"
---
# Source: code-server/templates/service.yaml
apiVersion: v1
kind: Service
metadata:
  name: code-server
  namespace: default
  labels:
    app.kubernetes.io/name: code-server
    helm.sh/chart: code-server-3.0.8
    app.kubernetes.io/instance: code-server
    app.kubernetes.io/managed-by: Helm
spec:
  type: ClusterIP
  ports:
    - port: 80
      targetPort: 8080
      protocol: TCP
      name: http
  selector:
    app.kubernetes.io/name: code-server
    app.kubernetes.io/instance: code-server
---
# Source: code-server/templates/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: code-server
  namespace: default
  labels:
    app.kubernetes.io/name: code-server
    helm.sh/chart: code-server-3.0.8
    app.kubernetes.io/instance: code-server
    app.kubernetes.io/managed-by: Helm
spec:
  replicas: 1
  strategy:
    type: Recreate
  selector:
    matchLabels:
      app.kubernetes.io/name: code-server
      app.kubernetes.io/instance: code-server
  template:
    metadata:
      labels:
        app.kubernetes.io/name: code-server
        app.kubernetes.io/instance: code-server
    spec:
      imagePullSecrets:
        []
      securityContext:
        fsGroup:
      initContainers:
      - name: init-chmod-data
        image: busybox:latest
        imagePullPolicy: IfNotPresent
        command:
          - sh
          - -c
          - |
            chown -R 0: /home/coder
        securityContext:
          runAsUser: 0
        volumeMounts:
        - name: data
          mountPath: /home/coder
      - name: copy-docker-binary
        image: docker:stable-dind
        command: ['sh', '-c', 'cp /usr/local/bin/docker /code-server-bin/']
        volumeMounts:
        - name: code-server-usr-local-bin
          mountPath: /code-server-bin
      containers:
        - name: code-server
          image: "linuxserver/code-server:"
          imagePullPolicy: Always
          securityContext:
            runAsUser: 0
            privileged: true
            capabilities:
              add: ["NET_ADMIN"]
          env:
          - name: PASSWORD
            valueFrom:
              secretKeyRef:
                name: code-server
                key: password
          volumeMounts:
          - name: data
            mountPath: /home/coder
          - name: code-server-usr-local-bin
            mountPath: /usr/local/bin
          ports:
            - name: http
              containerPort: 8080
              protocol: TCP
          livenessProbe:
            httpGet:
              path: /
              port: http
          readinessProbe:
            httpGet:
              path: /
              port: http
          resources:
            {}
      serviceAccountName: code-server
      volumes:
      - name: data
        persistentVolumeClaim:
          claimName: code-server
      - name: docker-graph-storage
        emptyDir: {}
      - name: code-server-usr-local-bin
        emptyDir: {}

NOTES:
1. Get the application URL by running these commands:
  echo "Visit http://127.0.0.1:8080 to use your application"
  kubectl port-forward --namespace default service/code-server 8080:http

Administrator credentials:

  Password: echo $(kubectl get secret --namespace default code-server -o jsonpath="{.data.password}" | base64 --decode)
```