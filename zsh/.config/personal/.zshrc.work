# Kubernetes {{{
function setup_kubernetes() {
  if [ /usr/local/bin/kubectl ]; then source <(kubectl completion zsh); fi
  export KUBECONFIG=/home/$USER/.bluemix/plugins/container-service/clusters/bmmrootd03m17d43d4v0/kube-config-hou02-asterisk_server.yml

  source <(microk8s.kubectl completion zsh)
  alias ku=microk8s.kubectl
  alias m8=microk8s
}
# }}}
# JavaScript {{{
function setup_npm() {
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}

function setup_npm_10() {
  npm_export
  nvm use v10
}
# }}}
# Golang {{{
function setup_golang() {
  export PATH=$PATH:/usr/local/go/bin
}

function setup_golang_9() {
  setup_golang
  export GOPATH=`pwd -P`
  [ -d src ] || echo no src folder!
  [ -d bin ] || echo no bin folder!
  [ -d pkg ] || echo no pkg folder!
}
# }}}
# Misc {{{
# }}}
# Password info {{{
# source ~/.password-store/aliases.sh
# }}}
# vim:foldmethod=marker:foldlevel=0
