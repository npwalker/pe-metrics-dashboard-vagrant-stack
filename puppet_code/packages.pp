package { [ 'vim', 'git', 'tree', 'telnet' ] :
  ensure => present,
}

package { ['curl', 'nss'] :
  ensure =>  latest,
}

