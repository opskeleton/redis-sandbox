
node default {
  class{ 'redis':
    append => true,
    unbind => true
  }
}
