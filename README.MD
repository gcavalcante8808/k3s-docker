K3S
---

This is an image with k3s (https://github.com/rancher/k3s), which is a compliant kubernetes implementation, packaged into a docker container using an Debian Image instead of the oficial scratch image.

### Requirements

Docker, docker-compose and openssl installed and working.

### How To use

Clone this repository into your machine with the command `https://raw.githubusercontent.com/gcavalcante8808/k3s-docker/master/docker-compose.yml`, access the folder created with `cd k3s-docker` and use the `docker-compose up -d` to finish the proccess.

After some time (usually a minute), you can see if all went good by running the command `docker-compose ps`; if the status is `Healthy` then you g2g.

You can check it using your local kubectl as well:

`KUBECONFIG=./output/kubeconfig.yaml kubectl version`

### Why should I Use this image?

This image is based on Debian 10 making it more easily extendable. Additionally, I provide EXPOSE, VOLUMES and HEALTHCHECK implementations on Dockerfile, making this image suitable for CI; actually we use it to smoke tests for helm.

### Supported ENVs

The main environment variables doesn't change from those in the oficial documentation: `https://rancher.com/docs/k3s/latest/en/installation/install-options/server-config/#advanced-options`, whom the most useful are:

| Env Var               | Description                                  | Default Value                                      |
| --------------------- | -------------------------------------------- | -------------------------------------------------- |
| K3S_TOKEN             | Token for admin user.                        | Random using openssl.                              |
| K3S_KUBECONFIG_OUTPUT | Path where k3s will put the Kubeconfig file. | /output/kubeconfig.yaml on the current dir.        |
| K3S_KUBECONFIG_MODE   | POSIX permission for kubeconfig file.        | 666: By default can be read and written by anyone. |

### How to extend

As this image is based on debian, you can create yours using some Dockerfile like the following (Eg):

```
FROM gcavalcante8808/k3s-docker
RUN apt-get update && \
    apt-get install --no-install-recommmends -y nfs-utils cifs-utils ceph-fuse
COPY my-own-entrypoint.sh /usr/local/bin/entrypoint
ENTRYPOINT  ["/usr/local/bin/entrypoint"]
```

### How to build different versions

If the latest image version  (currently k8s 1.18) isn't suitable for your job, you can build your own version by changing `K3S_VERSION` environment variable and using a `docker-compose build` command.

Author
------

Author: Gabriel Abdalla Cavalcante Silva (gabriel.cavalcante88@gmail.com)


