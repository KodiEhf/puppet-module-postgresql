class postgresql::agent(
  $version = '91')
{
  package {
    "pgagent":
      name => "pgagent_${version}",
      ensure => present,
      require => [ Yumrepo['postgres'], Service['postgresql'], ],
  }

  service {
    "pgagent":
      name => "pgagent_${version}",
      ensure => running,
      enable => true,
      hasstatus => true,
      hasrestart => true,      
  }
}
