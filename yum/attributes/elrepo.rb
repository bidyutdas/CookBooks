default['yum']['elrepo']['url'] = "http://elrepo.org/mirrors-elrepo.el#{node['platform_version'].to_i}"
default['yum']['elrepo']['key'] = "RPM-GPG-KEY-elrepo.org"
default['yum']['elrepo']['key_url'] = "http://elrepo.org/#{node['yum']['elrepo']['key']}"
default['yum']['elrepo']['includepkgs'] = nil
default['yum']['elrepo']['exclude'] = nil
