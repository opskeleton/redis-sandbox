puppet apply --modulepath=modules:static-modules manifests/default.pp\
  --node_terminus exec --external_nodes=/vagrant/lookup.sh --hiera_config hiera.yaml $@
