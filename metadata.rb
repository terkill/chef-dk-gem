name             'chef-dk-gem'
maintainer       'Franklin Hanson'
maintainer_email 'fhanson@gannett.com'
license          'Apache v2.0'
description      'Installs/Deletes chef-dk user gems'
version          '1.0.0'

depends 'chef-dk'

supports         'ubuntu', '>= 12.04'
supports         'debian', '>= 6.0'
%w(redhat centos scientific amazon).each do |os|
  supports       os, '>= 6.0'
end
supports         'fedora'
