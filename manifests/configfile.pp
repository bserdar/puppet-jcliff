# Utility to lay down generic configuration files, and
# notify jcliff. Use only the name of the file, not full path,
# directory is added.
define jcliff::configfile (
  $mode='0644',
  $owner=$jcliff::jcliff::configuration_user,
  $group=$jcliff::jcliff::configuration_group,
  $content = ''
  ) {
  file { "${jcliff::jcliff::configuration_directory}/${name}":
    mode    => $mode,
    owner   => $owner,
    group   => $group,
    content => $content,
    notify  => Exec['configure'],
  }
}
