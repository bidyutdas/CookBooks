include_recipe 'java::set_java_home'
jdk = Opscode::OpenJDK.new(node)
if platform_requires_license_acceptance?
  file "/opt/local/.dlj_license_accepted" do
    owner "root"
    group "root"
    mode "0400"
    action :create
    only_if { node['java']['accept_license_agreement'] }
  end
end

node['java']['openjdk_packages'].each do |pkg|
  package pkg do
    action :install
  end
end


if platform_family?('debian', 'rhel', 'fedora')
 java_alternatives 'set-java-alternatives' do
   java_location jdk.java_home
   default node['java']['set_default']
   priority jdk.alternatives_priority
   case node['java']['jdk_version'].to_s
   when "6"
     bin_cmds node['java']['jdk']['6']['bin_cmds']
   when "7"
     bin_cmds node['java']['jdk']['7']['bin_cmds']
   end
   action :set
 end
end
