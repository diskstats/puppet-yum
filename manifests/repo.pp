#
define yum::repo (
  $descr          = undef,
  $baseurl        = [],
  $mirrorlist     = undef,
  $failovermethod = 'priority',
  $enabled        = 1,
  $gpgcheck       = 1,
  $gpgkey         = [],
  $reposdir       = undef,
  $comment        = undef,
) {

  require ::yum::defaults

  validate_string($descr,$mirrorlist)
  validate_array($baseurl,$gpgkey)
  if $enabled != 0 and $enabled != 1 {
    fail("enabled parameter must be 0 or 1 not ${enabled}")
  }
  if $gpgcheck != 0 and $gpgcheck != 1 {
    fail("gpgcheck parameter must be 0 or 1 not ${gpgcheck}")
  }
  if ! $baseurl and ! mirrorlist {
    fail('baseurl or mirrorlist parameter must be specified')
  }

  $repositoryid  = $title

  $y_reposdir = getparam(Yum, 'reposdir')
  if $reposdir {
    $l_reposdir = $reposdir
  } elsif $y_reposdir {
    $l_reposdir = $y_reposdir[0]
  } else {
    $l_reposdir = $::yum::defaults::reposdir
  }

  file { "${l_reposdir}/${repositoryid}.repo":
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0644',
    content => template("${module_name}/repo.erb"),
  }

  if defined(Class['yum']) {
    Class['yum']->Yum::Repo <| |>
  }
}
