group{ 'puppet': ensure  => present }

node default {
  class{ 'redis':
    append => true,
    unbind => true
  }
}
