# Container Registry
Host your own container registry locally on your computer. Avoid paying hosting fees for your private images 💸

### Install
```sh
docker compose -f docker-compse.yml up
```
The simplest implementation is the built-in docker registry server. View the `docker-compose.yml` file to see how it's set up. Running the above command will start both the server and a UI to see your uploaded images.

Visit http://localhost:6868/ to access the dashboard.

### Push to registry
Remember to use the registry URL as the prefix:
```sh
docker build localhost:6969/my-image-name .
```

And include a tage (after the `:`) to uniquely identify the artifact:
```sh
docker push localhost:6969/my-image-name:my-release-tag
```

If you don't use the `localhost:6969` prefix, the docker command will default to use docker hub, which is where they take your money!
