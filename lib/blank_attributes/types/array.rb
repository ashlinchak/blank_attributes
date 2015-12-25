
module BlankAttributes
  module Types
    class Array
      class << self
        def normalize(value)
          return [] if value.blank?
          return [] unless value.is_a?(Array)
          value.reject(&:blank?)
        end
      end
    end
  end
end
