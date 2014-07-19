case node['platform']
when "amazon"
  default['yum']['epel']['url'] = "http://mirrors.fedoraproject.org/mirrorlist?repo=epel-6&arch=$basearch"
  default['yum']['epel']['baseurl'] = ""
  default['yum']['epel']['key'] = "RPM-GPG-KEY-EPEL-6"
else
  default['yum']['epel']['url'] = "http://mirrors.fedoraproject.org/mirrorlist?repo=epel-#{node['platform_version'].to_i}&arch=$basearch"
  default['yum']['epel']['baseurl'] = ""

  if node['platform_version'].to_i >= 6
    default['yum']['epel']['key'] = "RPM-GPG-KEY-EPEL-6"
  else
    default['yum']['epel']['key'] = "RPM-GPG-KEY-EPEL"
  end
end

default['yum']['epel']['key_url'] = "http://dl.fedoraproject.org/pub/epel/#{node['yum']['epel']['key']}"
default['yum']['epel']['includepkgs'] = nil
default['yum']['epel']['exclude'] = nil
