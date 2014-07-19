def whyrun_supported?
  true
end

action :add do
  unless ::File.exists?("/etc/yum.repos.d/#{new_resource.repo_name}.repo")
    Chef::Log.info "Adding #{new_resource.repo_name} repository to /etc/yum.repos.d/#{new_resource.repo_name}.repo"
    repo_config
  end
end

action :create do
  Chef::Log.info "Adding and updating #{new_resource.repo_name} repository in /etc/yum.repos.d/#{new_resource.repo_name}.repo"
  repo_config
end

action :remove do
  if ::File.exists?("/etc/yum.repos.d/#{new_resource.repo_name}.repo")
    Chef::Log.info "Removing #{new_resource.repo_name} repository from /etc/yum.repos.d/"
    file "/etc/yum.repos.d/#{new_resource.repo_name}.repo" do
      action :delete
    end
    new_resource.updated_by_last_action(true)
  end
end

action :update do
  repos ||= {}
  # If the repo is already enabled/disabled as per the resource, we don't want to converge the template resource.
  if ::File.exists?("/etc/yum.repos.d/#{new_resource.repo_name}.repo")
    ::File.open("/etc/yum.repos.d/#{new_resource.repo_name}.repo") do |file|
      repo_name ||= nil
      file.each_line do |line|
        case line
        when /^\[(\S+)\]/
          repo_name = $1
          repos[repo_name] ||= {}
        when /^(\S+?)=(.*)$/
          param, value = $1, $2
          repos[repo_name][param] = value
        else
        end
      end
    end
  else
    Chef::Log.error "Repo /etc/yum.repos.d/#{new_resource.repo_name}.repo does not exist, you must create it first"
  end
  if repos[new_resource.repo_name]['enabled'].to_i != new_resource.enabled
    Chef::Log.info "Updating #{new_resource.repo_name} repository in /etc/yum.repos.d/#{new_resource.repo_name}.repo (setting enabled=#{new_resource.enabled})"
    repo_config
  else
    Chef::Log.debug "Repository /etc/yum.repos.d/#{new_resource.repo_name}.repo is already set to enabled=#{new_resource.enabled}, skipping"
  end
end

private

def repo_config
  #import the gpg key. If it needs to be downloaded or imported from a cookbook
  #that can be done in the calling recipe
  if new_resource.key then
    yum_key new_resource.key
  end
  #get the metadata
  execute "yum-makecache" do
    command "yum -q makecache"
    action :nothing
  end
  #reload internal Chef yum cache
  ruby_block "reload-internal-yum-cache" do
    block do
      Chef::Provider::Package::Yum::YumCache.instance.reload
    end
    action :nothing
  end
  #write out the file
  template "/etc/yum.repos.d/#{new_resource.repo_name}.repo" do
    cookbook "yum"
    source "repo.erb"
    mode "0644"
    variables({
                :repo_name => new_resource.repo_name,
                :description => new_resource.description,
                :url => new_resource.url,
                :mirrorlist => new_resource.mirrorlist,
                :key => new_resource.key,
                :enabled => new_resource.enabled,
                :type => new_resource.type,
                :failovermethod => new_resource.failovermethod,
                :bootstrapurl => new_resource.bootstrapurl,
                :includepkgs => new_resource.includepkgs,
                :exclude => new_resource.exclude,
                :priority => new_resource.priority,
                :metadata_expire => new_resource.metadata_expire,
                :type => new_resource.type
              })
    #if new_resource.make_cache
    #  notifies :run, "execute[yum-makecache]", :immediately
    #  notifies :create, "ruby_block[reload-internal-yum-cache]", :immediately
    #end
  end
end
