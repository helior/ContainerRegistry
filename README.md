# Container Registry
Host your own container registry locally on your computer. Avoid paying hosting fees for your private images 💸

### Install
The simplest implementation is the built-in docker registry server. View the `docker-compose.yml` file to see how it's set up. Run the below command in your terminal to start both the server and a UI:
```sh
docker compose -f docker-compse.yml up
```

Now visit http://localhost:6868/ to access the dashboard 🎉

### Important Note
From a K8s node perspective, `localhost` will NOT resolve to your local development environment. You will have to push and pull to the IP address or hostname of your development computer in your network. Try `ifconfig | grep 192.168` to see what your machine is using on the current network.

### Push to registry
Remember to use the registry URL as the prefix:
```sh
docker build localhost:6969/my-image-name .
```

And include a tag (after the `:`) to identify the artifact:
```sh
docker push localhost:6969/my-image-name:latest
```

If you don't use the `localhost:6969` prefix, the docker command will default to use docker hub. In some cases you may not want that.

And remember, if pulling a tag from *outside* of your development environment (like, via K8s), use the ip address or hostname of that machine: `docker pull 192.168.1.213:6969/my-image-name:latest`
