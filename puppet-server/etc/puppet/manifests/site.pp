# Default node configuration
node default { }

# Ruby node configuration
node 'puppet-client-dns-name' {
  # Install ntp, enable at startup, and ensure it is running
  class { '::ntp':
    service_enable => true,
    service_ensure => running,
  }

  # Install apache, defaults are to enable and ensure running
  class { 'apache':
    default_vhost => true,
    docroot       => '/var/www/html',
  }

  # Install ruby with latest gems version
  class { 'ruby':
    gems_version  => 'latest'
  }

  # Install mysql server, change default password
  class { '::mysql::server':
    root_password => 'ChangeMe',
  }
}
