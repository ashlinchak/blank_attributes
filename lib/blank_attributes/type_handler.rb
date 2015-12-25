require "blank_attributes/types/string"

module BlankAttributes
  class TypeHandler
    def initialize(object)
      @object = object
    end

    def normalize(attr_name)
      income_value = value(attr_name)
      if @object.class.columns_hash[attr_name.to_s].array
        normalize_array(income_value)
      elsif @object.class.columns_hash[attr_name.to_s].type == :string
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
