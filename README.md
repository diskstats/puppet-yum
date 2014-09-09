# yum

#### Table of Contents

- [About](#about)
- [Examples](#example)
- [Parameters](#parameters)

## About
Lean RedHat Yum module, with the most common settings.

## Examples

1. Enable EPEL repository, using mirrorlist option.
```puppet
yum::repo { 'epel':
  descr       => 'Extra Packages for Enterprise Linux 7 - $basearch',
  mirrorlist  => 'https://mirrors.fedoraproject.org/metalink?repo=epel-7&arch=$basearch',
  gpgcheck    => 1,
  gpgkey      => ['http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7'],
}
```

3. Enable EPEL repository, using baseurl option.
```puppet
yum::repo { 'epel':
  descr     => 'Extra Packages for Enterprise Linux 7 - $basearch',
  baseurl   => ['http://download.fedoraproject.org/pub/epel/7/$basearch'],
  gpgcheck  => 1,
  gpgkey    => ['http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7'],
} 
```

4. 
```puppet
class { 'yum':
  purge  => ['/etc/yum.repos.d/'],
}

yum::repo { 'epel':
  descr     => "Extra Packages for Enterprise Linux ${::operatingsystemmajrelease} - \$basearch",
  baseurl   => ["http://download.fedoraproject.org/pub/epel/${::operatingsystemmajrelease}/\$basearch"],
  gpgcheck  => 1,
  gpgkey    => ["http://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-${::operatingsystemmajrelease}"],
}
```


## Parameters yum
See your OS man pages for a description of most of the parameters.

`cachedir`
- *type:* string
- *default:* '/var/cache/yum/$basearch/$releasever'

`keepcache`
- *type:* number
- *default:* 0

`debuglevel`
- *type:* number
- *default:* 2

`logfile`
- *type:* string
- *default:* '/var/log/yum.log'

`exactarch`
- *type:* number
- *default:* 1

`obsoletes`
- *type:* number
- *default:* 1

`gpgcheck`
- *type:* number
- *default:* 1

`plugins`
- *type:* number
- *default:* 1

`installonly_limit`
- *type:* number
- *default:* 3

`metadata_expire`
- *type:* string
- *default:* undef

`reposdir`
- *type:* sstring
- *default:* '/etc/yum.repos.d/'

`exclude`
- *type:* array
- *default:* []

`purge`
- *type:* array
- *default:* []

`comment`
- *type:* string
- *default:* undef
- *description:* Add an arbitary comment to the top of the configuration file.

## Parameters yum::repo
`descr`
- *type:* string

`baseurl`
- *type:* array
- *default:* []

`mirrorlist`
- *type:* string
- *default:* undef

`failovermethod`
- *type:* string
- *default:* 'priority'

`enabled`
- *type:* number
- *default:* 1

`gpgcheck`
- *type:* number
- *default:* 1

`gpgkey`
- *type:* array
- *default:* []

`comment`
- *type:* string
- *default:* undef
- *description:* Add an arbitary comment to the top of the configuration file.

