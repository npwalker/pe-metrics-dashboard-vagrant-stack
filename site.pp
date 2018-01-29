## site.pp ##

File { backup => false }

# DEFAULT NODE
# Node definitions in this file are merged with node data from the console. See
# http://docs.puppetlabs.com/guides/language_guide.html#nodes for more on
# node definitions.

# The default node definition matches any node lacking a more specific node
# definition. If there are no other nodes in this file, classes declared here
# will be included in every node's catalog, *in addition* to any classes
# specified in the console for that node.

node default {
  # This is where you can declare classes for all nodes.
  # Example:
  #   class { 'my_class': }

  if $::metrics == 'true' {
    class { 'pe_metric_curl_cron_jobs' :
      collection_frequency =>  1,
      influxdb_host        => 'pe-metrics-dashboard',
    }
  }
  if $::metrics_dashboard == 'true' {
    class { 'pe_metrics_dashboard':
      add_dashboard_examples => true,
      overwrite_dashboards   => false,
      influxdb_database_name => ['pe_metrics','telegraf','graphite'],
      configure_telegraf     => false,
      enable_telegraf        => false,
      master_list            => ['master201732-centos'],
      puppetdb_list          => ['master201732-centos'],
    }
  }
}
