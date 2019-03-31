K3SOnDocker
-----------

This is an image with k3s (https://github.com/rancher/k3s) packaged into a docker container.

### Requirements

Docker and docker-compose installed and working.

### How To use

Clone this repository into your machine with the command `git clone github.com/gcavalcante8808/k3sdocker.git`, access the folder created with `cd k3sdocker` and use the `docker-compose up -d` to finish the proccess.

After a minute, test the k3s using the command `docker-compose exec node1 k3s kubectl get nodes` and verify if the node1 is marked as Ready.

### How to configure kubectl to access k3s

You can do it in two ways:

 a. Use the alias 'k3sctl' by sourcing the file aliases.sh using the command: `source aliases.sh` from the projects folder;
 b. Find the container name or id using the command `docker ps`; Then, Copy the kubeconfig file from the container to your machine using `docker cp <NAMEorIDofContainer>:/etc/rancher/k3s/k3s.yaml ~/.kube/config`. (Beware that this action will override your current kubectl config).

Author
------

Author: Gabriel Abdalla Cavalcante Silva (gabriel.cavalcante88@gmail.com)

