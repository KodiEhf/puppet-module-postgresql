class postgresql::client($version) {
  package { "postgresql${version}":
    ensure => present,
  }
}
