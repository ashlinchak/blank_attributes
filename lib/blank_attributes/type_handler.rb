require "blank_attributes/types/string"
require "blank_attributes/types/array"

module BlankAttributes
  class TypeHandler
    STRING_TYPES = [:string, :text]
    ARRAY_TYPES = [:array]

    def initialize(object)
      @object = object
    end

    def normalize(attr_name)
      income_value = value(attr_name)
      attr_type = @object.class.columns_hash[attr_name.to_s]
      if attr_type.respond_to?(:array) && attr_type.array == true
        normalize_array(income_value)
      elsif STRING_TYPES.include?(attr_type.type)
        normalize_string(income_value)
      else
        income_value
      end
    rescue
      income_value
    end

    private

    def normalize_array(income_value)
      BlankAttributes::Types::Array.normalize(income_value)
    end

    def normalize_string(income_value)
      BlankAttributes::Types::String.normalize(income_value)
    end

    def value(attr_name)
      @object.send(attr_name.to_sym)
    end
  end
end
