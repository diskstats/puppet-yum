#
class yum (
  $cachedir           = $::yum::defaults::cachedir,
  $keepcache          = $::yum::defaults::keepcache,
  $debuglevel         = $::yum::defaults::debuglevel,
  $logfile            = $::yum::defaults::logfile,
  $exactarch          = $::yum::defaults::exactarch,
  $obsoletes          = $::yum::defaults::obsoletes,
  $gpgcheck           = $::yum::defaults::gpgcheck,
  $plugins            = $::yum::defaults::plugins,
  $installonly_limit  = $::yum::defaults::installonly_limit,
  $metadata_expire    = $::yum::defaults::metadata_expire,
  $reposdir           = $::yum::defaults::reposdir,
  $exclude            = $::yum::defaults::exclude,
  $purge              = $::yum::defaults::purge,
  $comment            = $::yum::defaults::comment,
) inherits yum::defaults {

  if $::osfamily != 'RedHat' {
    fail("${module_name} does not support ${::osfamily}")
  }

  case $::operatingsystemmajrelease {
    5,6,7: { }
    default: {
      fail("${module_name} does not support ${::operatingsystemmajrelease}")
    }
  }
  validate_string($cachedir, $logfile, $metadata_expire)
  validate_array($exclude, $reposdir)

  package { 'yum':
    ensure => installed,
  }

  file { '/etc/yum.conf':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template("${module_name}/yum.conf.erb"),
  }

  file { $reposdir:
    ensure  => directory,
    owner   => root,
    group   => root,
    mode    => '0755',
    recurse => true,
    force   => true,
  }

  if $purge {
    File[$purge] {
      purge   => true,
    }
  }

  Package['yum']->File['/etc/yum.conf']
}
