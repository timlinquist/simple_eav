module SimpleEav
  module ClassMethods
    def set_simple_eav_column name
      @@column = name
    end
    def simple_eav_column; @@column end
  end

  def self.included(base)
    base.extend ClassMethods
  end
end
