#pg_packages = case node['platform']

#when "amazon"
 # %w{postgresql-devel}
#end
node['postgresql']['client']['packages'].each do |pg_pack|

  package pg_pack

end
#pg_packages.each do |pg_pack|
 # package pg_pack do
  #  action :nothing
  #end.run_action(:install)
#end

#gem_package "pg" do
  #action :nothing
#end.run_action(:install)
