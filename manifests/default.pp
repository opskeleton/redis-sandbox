node default {
  class{'redis':
    append => true,
  }

  redis::bind{'allow all':
    bind => '0.0.0.0'
  }

  if $operatingsystem == 'Ubuntu' {
    package{'software-properties-common':
        ensure => present
    } -> Exec <||>

    Service {
      provider => systemd
    }
  }
}
