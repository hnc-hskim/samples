
### Extention 설치시 pod가 재시작하는 문제
```
root권한으로 실행하도록 변경

securityContext:
  enabled: true
  fsGroup: 0
  runAsUser: 0
``` 