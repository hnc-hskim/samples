#!/bin/bash
kubectl get pods "$HOSTNAME" || (
    echo "Use kubens to switch to the namespace of this instance and try again!"
    echo "(we can't do this for you since we don't know the namespace name)"
    exit 1
)
kubectl delete pod "$HOSTNAME"