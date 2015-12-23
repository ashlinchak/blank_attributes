require 'blank_attributes/type_handler'

module BlankAttributes
  module Blankable
    def blank_attribute(*args)
      class_attribute :blankable_attributes
      self.blankable_attributes = args.map(&:to_sym)

      include BlankAttributes::Blankable::BlankableMethods
    end
    alias_method :blank_attributes, :blank_attribute

    def has_blankable_attribute?
      blankable_attributes.any?
    end

    module BlankableMethods
      def self.included(klass)
        klass.class_eval do
          before_validation :normalize_blank_attributes
          skip_callback :validate, :before, :normalize_blank_attributes, if: :skip_normalize_blank_atttributes?

          klass.class_eval do
            include BlankAttributes::Blankable::InstanceMethods
          end
        end
      end
    end

    module InstanceMethods
      def has_blankable_attribute?
        blankable_attributes.any?
      end

      def normalize_blank_attributes
        return if skip_normalize_blank_atttributes?
        type_handler = BlankAttributes::TypeHandler.new(self)

        blankable_attributes.each do |attribute|
          next unless self.respond_to?(attribute.to_sym) && self.respond_to?("#{attribute}=")
          value = type_handler.normalize(attribute)
          self.send "#{attribute}=", value
        end
      end

      def blank_attribute?(attribute_name)
        return false if attribute_name.blank?
        blankable_attributes.include? attribute_name.to_sym
      end

      def skip_normalize_blank_atttributes?
        @skip_normalize || false
      end

      def skip_normalize_blank_atttributes=(skip)
        @skip_normalize = skip
      end
    end
  end
end
