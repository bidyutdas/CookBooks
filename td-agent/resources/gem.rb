actions :install, :upgrade, :remove, :purge

attribute :package_name,   :kind_of => String, :name_attribute => true, :required => true
attribute :version,        :kind_of => String
attribute :source,         :kind_of => String
attribute :options,        :kind_of => String
attribute :gem_binary,     :kind_of => String, :default => ""
attribute :response_file,  :kind_of => String
attribute :plugin,         :kind_of => [TrueClass, FalseClass], :default => false


def initialize(*args)
  super
  @action = :install
  @provider = Chef::Provider::Package::TdRubygems
end
