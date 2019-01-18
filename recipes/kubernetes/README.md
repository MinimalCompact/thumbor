


## Running on Google Kubernetes

The `gce-*.yaml` examples have been tested running `1.11.5-gke.5`


Make sure your environment is setup by running:
```
gcloud auth login
gcloud auth configure-docker
gcloud components install kubectl;
```


Then to apply each confguration to your cluster:
```
kubectl apply -f gce-simple-ingress.yaml
```



## Other Kubernetes exampels

Help wanted!  If you have run thumbor on Kubernetes, please post examples to help other people get started.

