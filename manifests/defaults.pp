#
class yum::defaults {
  $cachedir           = '/var/cache/yum/$basearch/$releasever'
  $keepcache          = 0
  $debuglevel         = 2
  $logfile            = '/var/log/yum.log'
  $exactarch          = 1
  $obsoletes          = 1
  $gpgcheck           = 1
  $plugins            = 1
  $installonly_limit  = 3
  $metadata_expire    = undef
  $reposdir           = ['/etc/yum.repos.d/']
  $exclude            = []
  $purge              = []
  $comment            = undef
}
