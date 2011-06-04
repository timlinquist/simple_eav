module SimpleEav
  module ClassMethods
    def configure_simple_eav(column)
      @@column = column.to_sym
      serialize @@column
    end

    def simple_eav_column
      @@column if defined? @@column
    end
  end

  def self.included(base)
    base.extend ClassMethods
  end

  def simple_eav_column
    self.class.simple_eav_column
  end

  def simple_eav_attributes
    self.send(simple_eav_column.to_sym) || {}
  end

  def simple_eav_attributes=(attributes={})
    self.send("#{simple_eav_column}=", attributes)
  end

  def respond_to?(method, include_private=false)
    super || simple_eav_attributes.has_key?(method)
  end

  def method_missing(method, *args, &block)
    if method.to_s =~ /=$/
      _attributes = self.simple_eav_attributes
      setter = method.to_s.gsub(/=/, '')
      _attributes[setter.to_sym] = args.shift
      self.simple_eav_attributes = _attributes
    elsif simple_eav_attributes.has_key?(method.to_sym)
      simple_eav_attributes[method.to_sym]
    else
      super(method, *args, &block)
    end
  end
end
