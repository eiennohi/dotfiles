function mkcd takedir() {
  mkdir -p $@ && cd ${@:$#}
}
