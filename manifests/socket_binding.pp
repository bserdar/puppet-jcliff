define jcliff::socket_binding(
  $name,
  $port) {
  jcliff::configfile { "socket-binding-${name}":
    content => template('jcliff/socket-binding.conf.erb'),
  }
}
