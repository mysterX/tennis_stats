class PlayerImport < ActiveRecord::Base
  attr_accessor
  serialize :msgs, Hash
end
