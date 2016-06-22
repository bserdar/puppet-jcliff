define jcliff::teiid_salesforce_ra(
  $template_name='jcliff/teiid_salesforce_resource_adapter.conf.erb',
  $transaction_support='NoTransaction',
  $flush_strategy='FailingConnectionOnly',
  $jndi_name,
  $url,
  $password,
  $username
) {
  jcliff::configfile { "teiid-salesforce-ra-${name}":
    content => template($template_name),
  }
}
