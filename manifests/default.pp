node default {
  class{'redis':
    append => true,
  }

  redis::bind{'allow all':
    bind => '0.0.0.0'
  }

  if $operatingsystem == 'Ubuntu' {
    Service {
      provider => systemd
    }
  }
}
