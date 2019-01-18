


## Running on Google Kubernetes

The `gke-*.yaml` examples have been tested running `1.11.5-gke.5`


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


This example uses [thumbor-cloud-storage](https://github.com/Superbalist/thumbor-cloud-storage) loader to read images.  Either change it, or make usre your project and buket are configured.
```
- name: LOADER
  value: "thumbor_cloud_storage.loaders.cloud_storage_loader"
- name: CLOUD_STORAGE_PROJECT_ID
  value: "your-project-id"
- name: CLOUD_STORAGE_BUCKET_ID
  value: "your.bucket.id"
```



### Wishlist

This example is really the most basic hello world.  It would be great to post
more example configuraitons showing more robust solutions.  In particular

* Running with nginx for local cache
* Running on other k8s engines (digitalocean, aws, etc)



