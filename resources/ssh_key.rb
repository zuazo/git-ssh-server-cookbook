
actions :add

attribute :keyname, :kind_of => String, :name_attribute => true
attribute :key, :kind_of => String, :required => true
attribute :keytype, :kind_of => String, :default => 'ssh-rsa'
attribute :base_path, :kind_of => String, :default => nil

def initialize(*args)
  super
  @action = :add
end

