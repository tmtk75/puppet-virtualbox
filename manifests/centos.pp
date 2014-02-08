#
# reference: http://www.if-not-true-then-false.com/2010/install-virtualbox-with-yum-on-fedora-centos-red-hat-rhel/
#
class virtualbox::centos {
  yumrepo { virtualbox:
    descr    => "Oracle Linux / RHEL / CentOS-\$releasever / \$basearch - VirtualBox",
    name     => "virtualbox",
    baseurl  => "http://download.virtualbox.org/virtualbox/rpm/el/\$releasever/\$basearch",
    enabled  => 1,
    gpgcheck => 1,
    gpgkey   => "http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc",
  }

  exec { epel:
    command => "rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm",
    creates => "/etc/yum.repos.d/epel.repo",
    path    => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    require => Yumrepo[virtualbox],
  }

  class dependencies {
    package { [
      "binutils",
      "gcc",
      "make",
      "patch",
      "libgomp",
      "glibc-headers",
      "glibc-devel",
      "kernel-headers",
      "kernel-devel",
      "dkms",
      ]:
      ensure  => present,
      require => Exec[epel],
    }
  }
  include dependencies

  package { "VirtualBox-4.3":
    ensure  => present,
    require => Class[dependencies],
  }

  # NOTE: After installation, you need to initialize
  #   $ service vboxdrv setup
  #   $ usermod -a -G vboxusers <your-username>
  #   $ VirtualBox
}
