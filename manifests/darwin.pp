class virtualbox::darwin {
  exec { 'Kill Virtual Box Processes':
    command     => 'pkill "VBoxXPCOMIPCD" || true && pkill "VBoxSVC" || true && pkill "VBoxHeadless" || true',
    path        => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    refreshonly => true,
  }

  package { 'VirtualBox-4.3.10-93012-OSX.dmg':
    ensure   => installed,
    provider => 'pkgdmg',
    source   => 'http://download.virtualbox.org/virtualbox/4.3.10/VirtualBox-4.3.10-93012-OSX.dmg',
    require  => Exec['Kill Virtual Box Processes'],
  }
}
