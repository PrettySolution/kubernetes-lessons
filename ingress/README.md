### Nginx
1. $ `snap install microk8s --classic --channel=1.19`
1. $ `microk8s.start`
1. $ `microk8s.enable`
1. $ `microk8s enable ingress`
1. $ `microk8s.kubectl apply -f nginx-ingress.yml`
1. Now you can test ingress

### Adminer
The same as for Nginx

### K8s Dashboard
1. $ `microk8s enable dashboard`
1. $ `microk8s enable rbac`
1. $ `microk8s.kubectl apply -f dashboard-ingress.yml`
1. $ `microk8s.kubectl -n kube-system describe secret $(microk8s.kubectl -n kube-system get secret | grep admin-user | awk '{print $1}')`