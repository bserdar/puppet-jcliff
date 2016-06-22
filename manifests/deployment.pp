define jcliff::deployment(
  $path) {

  jcliff::configfile { "${name}-deploy" :
    content => template("jcliff/deployment.conf.erb"),
  }
}
