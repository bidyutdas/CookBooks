case node['platform']
when "fedora"
  default['yum']['remi']['url'] = "http://rpms.famillecollet.com/fedora/#{node['platform_version'].to_i}/remi/mirror"
else
  default['yum']['remi']['url'] = "http://rpms.famillecollet.com/enterprise/#{node['platform_version'].to_i}/remi/mirror"
end

default['yum']['remi']['key'] = "RPM-GPG-KEY-remi"
default['yum']['remi']['key_url'] = "http://rpms.famillecollet.com/#{node['yum']['remi']['key']}"
default['yum']['remi']['includepkgs'] = nil
default['yum']['remi']['exclude'] = nil
