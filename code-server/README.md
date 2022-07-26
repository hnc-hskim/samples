## helm chart 버전 관리
- Chart.yaml
```
version: 3.0.5
```

- deploy.sh
```
# Chart.yaml에서 정의한 버전으로 스크립트 수정(패키지 파일명)
mv code-server-3.0.5.tgz ../../packages/code-server/
```

## virtual service exmaple
```
apiVersion: networking.istio.io/v1beta1
kind: VirtualService
metadata:
  annotations:
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"networking.istio.io/v1beta1","kind":"VirtualService","metadata":{"annotations":{},"name":"code-server-ingress","namespace":"code-server"},"spec":{"gateways":["istio-system/apps-dns-ingressgateway"],"hosts":["mycode.apps.orca.cloud.hancom.com"],"http":[{"match":[{"uri":{"prefix":"/"}}],"route":[{"destination":{"host":"code-server","port":{"number":80}}}]}]}}
  creationTimestamp: "2022-07-25T05:47:26Z"
  generation: 1
  managedFields:
  - apiVersion: networking.istio.io/v1beta1
    fieldsType: FieldsV1
    fieldsV1:
      f:metadata:
        f:annotations:
          .: {}
          f:kubectl.kubernetes.io/last-applied-configuration: {}
      f:spec:
        .: {}
        f:gateways: {}
        f:hosts: {}
        f:http: {}
    manager: kubectl-client-side-apply
    operation: Update
    time: "2022-07-25T05:47:26Z"
  name: code-server-ingress
  namespace: code-server
  resourceVersion: "100021654"
  uid: 949baac2-39fd-4c85-b9ac-2dd1ba34ec44
spec:
  gateways:
  - istio-system/apps-dns-ingressgateway
  hosts:
  - mycode.apps.orca.cloud.hancom.com
  http:
  - match:
    - uri:
        prefix: /
    route:
    - destination:
        host: code-server
        port:
          number: 80
```

https://docs.docker.com/engine/install/ubuntu/


```
code@854bb49e06d2:~/workspace$ sudo dockerd
INFO[2022-07-21T03:36:49.044998105Z] Starting up                                  
INFO[2022-07-21T03:36:49.046650771Z] libcontainerd: started new containerd process  pid=397
INFO[2022-07-21T03:36:49.046703777Z] parsed scheme: "unix"                         module=grpc
INFO[2022-07-21T03:36:49.046728560Z] scheme "unix" not registered, fallback to default scheme  module=grpc
INFO[2022-07-21T03:36:49.046751650Z] ccResolverWrapper: sending update to cc: {[{unix:///var/run/docker/containerd/containerd.sock  <nil> 0 <nil>}] <nil> <nil>}  module=grpc
INFO[2022-07-21T03:36:49.046760014Z] ClientConn switching balancer to "pick_first"  module=grpc
WARN[0000] containerd config version `1` has been deprecated and will be removed in containerd v2.0, please switch to version `2`, see https://github.com/containerd/containerd/blob/main/docs/PLUGINS.md#version-header 
INFO[2022-07-21T03:36:49.076502215Z] starting containerd                           revision=10c12954828e7c7c9b6e0ea9b0c02b01407d3ae1 version=1.6.6
INFO[2022-07-21T03:36:49.086539564Z] loading plugin "io.containerd.content.v1.content"...  type=io.containerd.content.v1
INFO[2022-07-21T03:36:49.087234213Z] loading plugin "io.containerd.snapshotter.v1.aufs"...  type=io.containerd.snapshotter.v1
INFO[2022-07-21T03:36:49.087609074Z] skip loading plugin "io.containerd.snapshotter.v1.aufs"...  error="aufs is not supported (modprobe aufs failed: exec: \"modprobe\": executable file not found in $PATH \"\"): skip plugin" type=io.containerd.snapshotter.v1
INFO[2022-07-21T03:36:49.087708526Z] loading plugin "io.containerd.snapshotter.v1.btrfs"...  type=io.containerd.snapshotter.v1
INFO[2022-07-21T03:36:49.088055465Z] skip loading plugin "io.containerd.snapshotter.v1.btrfs"...  error="path /var/lib/docker/containerd/daemon/io.containerd.snapshotter.v1.btrfs (overlay) must be a btrfs filesystem to be used with the btrfs snapshotter: skip plugin" type=io.containerd.snapshotter.v1
INFO[2022-07-21T03:36:49.088088048Z] loading plugin "io.containerd.snapshotter.v1.devmapper"...  type=io.containerd.snapshotter.v1
WARN[2022-07-21T03:36:49.088096970Z] failed to load plugin io.containerd.snapshotter.v1.devmapper  error="devmapper not configured"
INFO[2022-07-21T03:36:49.088102842Z] loading plugin "io.containerd.snapshotter.v1.native"...  type=io.containerd.snapshotter.v1
INFO[2022-07-21T03:36:49.097884392Z] loading plugin "io.containerd.snapshotter.v1.overlayfs"...  type=io.containerd.snapshotter.v1
INFO[2022-07-21T03:36:49.099335342Z] loading plugin "io.containerd.snapshotter.v1.zfs"...  type=io.containerd.snapshotter.v1
INFO[2022-07-21T03:36:49.099772941Z] skip loading plugin "io.containerd.snapshotter.v1.zfs"...  error="path /var/lib/docker/containerd/daemon/io.containerd.snapshotter.v1.zfs must be a zfs filesystem to be used with the zfs snapshotter: skip plugin" type=io.containerd.snapshotter.v1
INFO[2022-07-21T03:36:49.099833618Z] loading plugin "io.containerd.metadata.v1.bolt"...  type=io.containerd.metadata.v1
WARN[2022-07-21T03:36:49.100043160Z] could not use snapshotter devmapper in metadata plugin  error="devmapper not configured"
INFO[2022-07-21T03:36:49.100093000Z] metadata content store policy set             policy=shared
INFO[2022-07-21T03:36:49.116617115Z] loading plugin "io.containerd.differ.v1.walking"...  type=io.containerd.differ.v1
INFO[2022-07-21T03:36:49.116683589Z] loading plugin "io.containerd.event.v1.exchange"...  type=io.containerd.event.v1
INFO[2022-07-21T03:36:49.116696951Z] loading plugin "io.containerd.gc.v1.scheduler"...  type=io.containerd.gc.v1
INFO[2022-07-21T03:36:49.116733553Z] loading plugin "io.containerd.service.v1.introspection-service"...  type=io.containerd.service.v1
INFO[2022-07-21T03:36:49.116747394Z] loading plugin "io.containerd.service.v1.containers-service"...  type=io.containerd.service.v1
INFO[2022-07-21T03:36:49.116768219Z] loading plugin "io.containerd.service.v1.content-service"...  type=io.containerd.service.v1
INFO[2022-07-21T03:36:49.116786190Z] loading plugin "io.containerd.service.v1.diff-service"...  type=io.containerd.service.v1
INFO[2022-07-21T03:36:49.116805213Z] loading plugin "io.containerd.service.v1.images-service"...  type=io.containerd.service.v1
INFO[2022-07-21T03:36:49.116813885Z] loading plugin "io.containerd.service.v1.leases-service"...  type=io.containerd.service.v1
INFO[2022-07-21T03:36:49.116832627Z] loading plugin "io.containerd.service.v1.namespaces-service"...  type=io.containerd.service.v1
INFO[2022-07-21T03:36:49.116859223Z] loading plugin "io.containerd.service.v1.snapshots-service"...  type=io.containerd.service.v1
INFO[2022-07-21T03:36:49.116867893Z] loading plugin "io.containerd.runtime.v1.linux"...  type=io.containerd.runtime.v1
INFO[2022-07-21T03:36:49.117117616Z] loading plugin "io.containerd.runtime.v2.task"...  type=io.containerd.runtime.v2
INFO[2022-07-21T03:36:49.117368337Z] loading plugin "io.containerd.monitor.v1.cgroups"...  type=io.containerd.monitor.v1
INFO[2022-07-21T03:36:49.117655685Z] loading plugin "io.containerd.service.v1.tasks-service"...  type=io.containerd.service.v1
INFO[2022-07-21T03:36:49.117697582Z] loading plugin "io.containerd.grpc.v1.introspection"...  type=io.containerd.grpc.v1
INFO[2022-07-21T03:36:49.117706161Z] loading plugin "io.containerd.internal.v1.restart"...  type=io.containerd.internal.v1
INFO[2022-07-21T03:36:49.117746087Z] loading plugin "io.containerd.grpc.v1.containers"...  type=io.containerd.grpc.v1
INFO[2022-07-21T03:36:49.117769973Z] loading plugin "io.containerd.grpc.v1.content"...  type=io.containerd.grpc.v1
INFO[2022-07-21T03:36:49.117791011Z] loading plugin "io.containerd.grpc.v1.diff"...  type=io.containerd.grpc.v1
INFO[2022-07-21T03:36:49.117809918Z] loading plugin "io.containerd.grpc.v1.events"...  type=io.containerd.grpc.v1
INFO[2022-07-21T03:36:49.117828214Z] loading plugin "io.containerd.grpc.v1.healthcheck"...  type=io.containerd.grpc.v1
INFO[2022-07-21T03:36:49.117849402Z] loading plugin "io.containerd.grpc.v1.images"...  type=io.containerd.grpc.v1
INFO[2022-07-21T03:36:49.117868045Z] loading plugin "io.containerd.grpc.v1.leases"...  type=io.containerd.grpc.v1
INFO[2022-07-21T03:36:49.117906844Z] loading plugin "io.containerd.grpc.v1.namespaces"...  type=io.containerd.grpc.v1
INFO[2022-07-21T03:36:49.117949286Z] loading plugin "io.containerd.internal.v1.opt"...  type=io.containerd.internal.v1
INFO[2022-07-21T03:36:49.118264000Z] loading plugin "io.containerd.grpc.v1.snapshots"...  type=io.containerd.grpc.v1
INFO[2022-07-21T03:36:49.118294370Z] loading plugin "io.containerd.grpc.v1.tasks"...  type=io.containerd.grpc.v1
INFO[2022-07-21T03:36:49.118304108Z] loading plugin "io.containerd.grpc.v1.version"...  type=io.containerd.grpc.v1
INFO[2022-07-21T03:36:49.118328811Z] loading plugin "io.containerd.tracing.processor.v1.otlp"...  type=io.containerd.tracing.processor.v1
INFO[2022-07-21T03:36:49.118352560Z] skip loading plugin "io.containerd.tracing.processor.v1.otlp"...  error="no OpenTelemetry endpoint: skip plugin" type=io.containerd.tracing.processor.v1
INFO[2022-07-21T03:36:49.118364503Z] loading plugin "io.containerd.internal.v1.tracing"...  type=io.containerd.internal.v1
ERRO[2022-07-21T03:36:49.118380807Z] failed to initialize a tracing processor "otlp"  error="no OpenTelemetry endpoint: skip plugin"
INFO[2022-07-21T03:36:49.118674147Z] serving...                                    address=/var/run/docker/containerd/containerd-debug.sock
INFO[2022-07-21T03:36:49.118754564Z] serving...                                    address=/var/run/docker/containerd/containerd.sock.ttrpc
INFO[2022-07-21T03:36:49.118801870Z] serving...                                    address=/var/run/docker/containerd/containerd.sock
INFO[2022-07-21T03:36:49.118825699Z] containerd successfully booted in 0.043426s  
INFO[2022-07-21T03:36:49.125344093Z] parsed scheme: "unix"                         module=grpc
INFO[2022-07-21T03:36:49.125382707Z] scheme "unix" not registered, fallback to default scheme  module=grpc
INFO[2022-07-21T03:36:49.125410271Z] ccResolverWrapper: sending update to cc: {[{unix:///var/run/docker/containerd/containerd.sock  <nil> 0 <nil>}] <nil> <nil>}  module=grpc
INFO[2022-07-21T03:36:49.125426360Z] ClientConn switching balancer to "pick_first"  module=grpc
INFO[2022-07-21T03:36:49.127163518Z] parsed scheme: "unix"                         module=grpc
INFO[2022-07-21T03:36:49.127212842Z] scheme "unix" not registered, fallback to default scheme  module=grpc
INFO[2022-07-21T03:36:49.127230434Z] ccResolverWrapper: sending update to cc: {[{unix:///var/run/docker/containerd/containerd.sock  <nil> 0 <nil>}] <nil> <nil>}  module=grpc
INFO[2022-07-21T03:36:49.127252998Z] ClientConn switching balancer to "pick_first"  module=grpc
ERRO[2022-07-21T03:36:49.129036495Z] failed to mount overlay: operation not permitted  storage-driver=overlay2
ERRO[2022-07-21T03:36:49.129173026Z] exec: "fuse-overlayfs": executable file not found in $PATH  storage-driver=fuse-overlayfs
ERRO[2022-07-21T03:36:49.129272012Z] AUFS was not found in /proc/filesystems       storage-driver=aufs
ERRO[2022-07-21T03:36:49.129741387Z] failed to mount overlay: operation not permitted  storage-driver=overlay
WARN[2022-07-21T03:36:49.130052449Z] Unable to setup quota: operation not permitted 
WARN[2022-07-21T03:36:49.165925316Z] Your kernel does not support cgroup blkio weight 
WARN[2022-07-21T03:36:49.165962743Z] Your kernel does not support cgroup blkio weight_device 
WARN[2022-07-21T03:36:49.165966898Z] Your kernel does not support cgroup blkio throttle.read_bps_device 
WARN[2022-07-21T03:36:49.165969458Z] Your kernel does not support cgroup blkio throttle.write_bps_device 
WARN[2022-07-21T03:36:49.165971576Z] Your kernel does not support cgroup blkio throttle.read_iops_device 
WARN[2022-07-21T03:36:49.165973978Z] Your kernel does not support cgroup blkio throttle.write_iops_device 
INFO[2022-07-21T03:36:49.166145930Z] Loading containers: start.                   
WARN[2022-07-21T03:36:49.168352003Z] Running iptables --wait -t nat -L -n failed with message: `iptables v1.8.4 (legacy): can't initialize iptables table `nat': Permission denied (you must be root)
Perhaps iptables or your kernel needs to be upgraded.`, error: exit status 3 
INFO[2022-07-21T03:36:49.195382434Z] stopping event stream following graceful shutdown  error="<nil>" module=libcontainerd namespace=moby
INFO[2022-07-21T03:36:49.195567445Z] stopping event stream following graceful shutdown  error="context canceled" module=libcontainerd namespace=plugins.moby
INFO[2022-07-21T03:36:49.195666684Z] stopping healthcheck following graceful shutdown  module=libcontainerd
failed to start daemon: Error initializing network controller: error obtaining controller instance: failed to create NAT chain DOCKER: iptables failed: iptables -t nat -N DOCKER: iptables v1.8.4 (legacy): can't initialize iptables table `nat': Permission denied (you must be root)
Perhaps iptables or your kernel needs to be upgraded.
 (exit status 3)
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
```

### 도커 엔진 실행
```
sudo dockerd
```