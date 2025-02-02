# Container Registry
Host your own container registry locally on your computer. Avoid paying hosting fees for your private images 💸

### Install
The simplest implementation is the built-in docker registry server. View the `docker-compose.yml` file to see how it's set up. Run the below command in your terminal to start both the server and a UI:
```sh
docker compose -f docker-compose.yml up
```

Now visit http://localhost:6868/ to access the dashboard 🎉

### Important Note
From a K8s node perspective, `localhost` will NOT resolve to your local development environment. You will have to push and pull to the IP address or hostname of your development computer in your network. Try `ifconfig | grep 192.168` to see what your machine is using on the current network. As an example, I'll use `192.168.1.213`

### Push to registry
Remember to use the registry URL as the prefix (including the port):
```sh
docker build 192.168.1.213:6969/my-image-name .
```

And include a tag (after the `:`) to identify the artifact:
```sh
docker push 192.168.1.213:6969/my-image-name:latest
```

If you don't use the `192.168.1.213:6969` prefix, the docker command will default to use docker hub. In which, you'll have to pay like a sucker (unless it's public)


### Pull from registry
If you're using minikube, you start minikube like this:
```sh
minikube start --insecure-registry "192.168.1.213:6969"
```
Replacing `192.168.1.213` with the IP where your registry is running.

If you're running k3s or k8s on a home server and want to fetch images from this registry, make sure to let the container run-time to use insecure repositories (because this server runs insecure. I know, I know...)
For k3s (using containerd), create the file `/etc/rancher/k3s/registries.yaml` and use this config:
```yaml
mirrors:
  "192.168.1.213:6969":
    endpoint:
      - "http://192.168.1.213:6969"
configs:
  "192.168.1.213:6969":
    tls:
      insecure_skip_verify: true
```

If you're building images from your Mac using Docker, let docker know you are pushing to an insecure registry. Add this to your `~/.docker/daemon.json`:
```json
{ "insecure-registries": [ "192.168.1.213:6969" ] }
```

Oh and remember, if pulling a tag from *outside* of your development environment (like, via K8s), use the ip address or hostname of that machine in your network: `docker pull 192.168.1.213:6969/my-image-name:latest`

### Free as in beer. ✌🏼
