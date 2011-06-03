module SimpleEav
  module ClassMethods
    def configure_simple_eav(column)
      symbolized_column= column.to_sym
      @@column = symbolized_column

      serialize symbolized_column
    end

    def simple_eav_column
      @@column if defined? @@column
    end
  end

  def self.included(base)
    base.extend ClassMethods
  end
end
