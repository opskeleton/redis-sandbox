# == Class: redis
#
#  A puppet module for redis, works on Ubuntu 12.10
#
# === Parameters
#
# Document parameters here.
#
# [*append*]
#  Enables aof persistency
#
# === Variables
#
# === Examples
#
#  class {redis:
#    append => true
#  }
#
# === Authors
#
# Author Name <narkisr@gmail.com>
#
# === Copyright
#
# Copyright 2013 Ronen Narkis , unless otherwise noted.
#
class redis($append=false) {
  include apt

  apt::ppa { 'ppa:chris-lea/redis-server': }

  package{'redis-server':
    ensure  => present,
    require => Apt::Ppa['ppa:chris-lea/redis-server']
  }

  if($append){
    editfile::config { 'append true':
      ensure => 'yes',
      path   => '/etc/redis/redis.conf',
      entry  => 'appendonly',
      sep    => ' ',
      }
  }
}
