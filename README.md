# Exkubed
This is a toy elixir project which shows how to setup a cluster of elixir nodes using kubernetes. It uses the Elixir 1.9's release mechanism to setup runtime env vars.

## Dev Setup
1. Install `elixir 1.9` and `erlang/OTP 22`
  ([asdf](https://github.com/asdf-vm/asdf) is our choice of version manager)
2. Install [docker](https://docs.docker.com/install/)
3. Install [minikube](https://minikube.sigs.k8s.io/docs/start/)
4. Install [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
5. Run `mix phx.server` to start the application

## Clustering on Kubernetes
The application uses libcluster to form a cluster, using the [Kubernetes](https://hexdocs.pm/libcluster/Cluster.Strategy.Kubernetes.html#content) strategy. This requires that the kubernetes pods and service have selectors and labels setup properly.

The `kubernetes_selector` config key set for libcluster should match the label metadata in the kubernetes deployment file. For instance in this project we use `app=exkubed` as the selector.

### Running a cluster locally
1. Start `minikube`
2. Get into the minikube context by running `eval $(minikube docker-env)`
3. Build the docker image `docker build -t exkubed:latest .`
4. Initialize the kubernetes serviceAccount, role and rbac by running `kubectl apply -f kube/permission.yaml`
5. Initialize the kubernetes pods and services by running `kubectl apply -f kube/deployment.yaml`

That's it, post this there would be a 4 pod cluster of exkubed application running. These pods will form a fully connected mesh of elixir nodes, which will detect new pods joining | old pods leaving the cluster.

### Running a cluster elsewhere
Same steps as above, except for step 1 and 2.

## Misc notes
- If your application is using older version of elixir, you may need to add distillery for release management. The way env vars are set would differ slightly. You would probably need to alter the `kube/deployment.yaml` file
- The app uses the `:ip` mode of libcluster. For other modes (`:dns` and `:hostname`) there would be changes required in the `kube/deployment.yaml` on how the `RELEASE_NODE` value is being generated
