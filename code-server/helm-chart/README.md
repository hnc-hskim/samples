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