require 'active_record'
require 'simple_eav'

class Person < ActiveRecord::Base
  include SimpleEav

  set_simple_eav_column :simple_attributes
end
