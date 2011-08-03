require 'active_record'
require 'simple_eav'

class Person < ActiveRecord::Base
  include SimpleEav
  configure_simple_eav :simple_attributes
  
  has_one :child
  accepts_nested_attributes_for :child
end

