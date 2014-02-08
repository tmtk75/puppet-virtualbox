class virtualbox {
  case $::operatingsystem {
    'Darwin' : { include virtualbox::darwin }
    'CentOS' : { include virtualbox::centos }
  }
}
