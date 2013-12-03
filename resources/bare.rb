
actions :create

attribute :name, :kind_of => String, :name_attribute => true
attribute :base_path, :kind_of => String, :default => nil
attribute :add_update_server_hook, :kind_of => [ TrueClass, FalseClass ], :default => false

def initialize(*args)
  super
  @action = :create
end

