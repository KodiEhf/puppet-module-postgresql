class postgresql::server(
  $version='91',
  $listen_addresses='localhost',
  $max_connections=100,
  $shared_buffers='24MB') {
 
    class { 'postgresql::client': 
      version => $version,
    }

    Class['postgresql::server'] -> Class['postgresql::client']

    package {
      "postgresql":
        name => "postgresql${version}-server",
        ensure => present,
        require => [ Yumrepo['postgres'], ],
    }
    
    File {
      owner => "postgres",
      group => "postgres",
    }
    
  # file { "pg_hba.conf":
  #   path => "/etc/postgresql/${version}/main/pg_hba.conf",
  #   source => "puppet:///modules/postgresql/pg_hba.conf",
  #   mode => 640,
  #   require => Package[$pkgname],
  # }

  # file { "postgresql.conf":
  #   path => "/etc/postgresql/${version}/main/postgresql.conf",
  #   content => template("postgresql/postgresql.conf.erb"),
  #   require => Package[$pkgname],
  # }

    file {
      "/var/log/postgres":
        ensure => directory,
        require => Package['postgresql'],
    }
        
    
    service {
      "postgresql":
        name => "postgresql-9.1",
        ensure => running,
        enable => true,
        hasstatus => true,
        hasrestart => true,
        subscribe => [Package["postgresql"],]
        #File["pg_hba.conf"],
        #File["postgresql.conf"]],
    }
  }
