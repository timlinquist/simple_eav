module SimpleEav
  module ClassMethods
    def configure_simple_eav(column)
      @@column = column.to_sym
      serialize @@column
    end

    def simple_eav_column; @@column end
  end

  def self.included(base)
    base.extend ClassMethods
  end

  def simple_eav_column
    self.class.simple_eav_column
  end

  private
  def nested_attributes
    associations_of_class.map{|assoc| "#{assoc}_attributes".to_sym }
  end

  def associations_of_class
    self.class.reflect_on_all_associations.map{|assoc| assoc.name.to_sym }
  end

  def actual_columns_of_table
    self.class.columns.map{|col| col.name.to_sym }
  end

  public
  def reserved_attributes
    associations_of_class + actual_columns_of_table + nested_attributes
  end

  def reserved_attribute?(attribute)
    reserved_attributes.include?(attribute)
  end

  def simple_eav_attributes
    _attributes = self.send(simple_eav_column.to_sym)
    _attributes.is_a?(Hash) ? _attributes : {}
  end

  def simple_eav_attributes=(attributes={})
    self.send("#{simple_eav_column}=", attributes)
  end

  def attributes=(_attributes={})
    #Iterate over each attribute:
    # - skip columns that are actually defined in the db
    # - remove undefined columns to prevent UnknownAttribute::Error from being thrown
    simple_eav_attrs = read_attribute(simple_eav_column.to_sym) || {}
    _attributes.each do |column,value|
      next if reserved_attribute?(column.to_sym)
      simple_eav_attrs[column] = value
      _attributes.delete(column)
    end
    self.simple_eav_attributes = simple_eav_attrs
    super(_attributes)
  end
  
  def assign_attributes(_attributes={})
    puts "\n\n\n\n I am assign Attributes!!! \n\n\n\n\n"
    #Iterate over each attribute:
    # - skip columns that are actually defined in the db
    # - remove undefined columns to prevent UnknownAttribute::Error from being thrown
    simple_eav_attrs = read_attribute(simple_eav_column.to_sym) || {}
    _attributes.each do |column,value|
      next if reserved_attribute?(column.to_sym)
      simple_eav_attrs[column] = value
      _attributes.delete(column)
    end
    self.simple_eav_attributes = simple_eav_attrs
    super(_attributes)
  end

  def respond_to?(method, include_private=false)
    return true if super(method, include_private)
    simple_eav_attributes.has_key?(method)
  end

  def method_missing(method, *args, &block)
    _attributes = read_attribute(simple_eav_column.to_sym) || {}
    puts "\n\n\n\n\n\n I AM BEING CALLED BITCHES \n\n\n\n\n"
    if method.to_s =~ /=$/
      setter = method.to_s.gsub(/=/, '')
      _attributes[setter.to_sym] = args.shift
      return self.simple_eav_attributes = _attributes
    elsif _attributes.has_key?(method.to_sym)
     return  _attributes[method.to_sym]
    else
      super(method, *args, &block)
    end
  end
end
