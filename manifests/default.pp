group{ 'puppet': ensure  => present }

node redis {
  class{redis:}
}
