
#case node['platform']

#when "redhat","centos","scientific","amazon"

 #default[:postgresql][:version] = "8.4"
  #set[:postgresql][:dir] = "/var/lib/pgsql/data"
  
#else
  #default[:postgresql][:version] = "8.4"
  #set[:postgresql][:dir]         = "/etc/postgresql/#{node[:postgresql][:version]}/main"
#end
default['postgresql']['client']['packages'] = %w{postgresql-devel}
