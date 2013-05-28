
actions :create

attribute :name, :kind_of => String, :name_attribute => true
attribute :base_path, :kind_of => String, :default => nil

def initialize(*args)
  super
  @action = :create
end

