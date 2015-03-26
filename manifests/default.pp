
node default {
  class{'redis':
    append          => true,
    manage_services => true
  }

  redis::bind{'allow all':
    bind => '0.0.0.0'
  }
}
