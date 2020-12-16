### Nginx
1. $ `snap install microk8s --classic --channel=1.19`
1. $ `microk8s.start`
1. $ `microk8s.enable`
1. $ `microk8s enable ingress`
1. $ `microk8s.kubectl apply -f nginx.yml`
1. Now you can test ingress

### Adminer
The same as for Nginx

### K8s Dashboard
microk8s enable dashboard
microk8s enable rbac
