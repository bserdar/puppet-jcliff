class jcliff::jcliff(
  $jboss_home='/usr/share/jbossas',
  $config_dir='/etc/jcliff',
  $management_host='localhost',
  $management_port='9999',
  $log_dir='/var/log',
  $jcliff_user='jboss',
  $jcliff_group='jboss',
  $jboss_service='jbossas'
) {

  $configuration_directory = $config_dir
  $configuration_user = $jcliff_user
  $configuration_group = $jcliff_group

  #Create directory for jcliff configurations 
  file { $config_dir:
    ensure  => 'directory',
    owner   => '${jcliff_user},
    group   => '${jcliff_user}',
    mode    => '0755',
  }

  exec { 'configure' :
    command   => "/usr/bin/jcliff --cli=${jboss_home}/bin/jboss-cli.sh -v --controller=${management_host}:${management_port} --output=${log_dir}/jcliff.log ${config_dir}/*",
    onlyif    => "[ $(/usr/bin/find ${config_dir} -type f -name '*.jcliff' | /usr/bin/wc -l) -gt 0 ]",
    logoutput => true,
    timeout   => 0,
    require   => [ File["${config_dir}"], Service['jbossas'] ],
    notify    => Exec['reload-check']
  }

 exec { 'reload-check' :
    onlyif  => "${jboss_home}/bin/jboss-cli.sh --controller=${management_host}:${management_port} --connect \":read-attribute(name=server-state)\" | grep reload-required",
    command => 'service jbossas restart',
    logoutput     => true
  }
}
