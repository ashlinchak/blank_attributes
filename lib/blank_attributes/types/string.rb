
module BlankAttributes
  module Types
    class String
      class << self
        def normalize(str)
          return nil if str.blank?
          return str unless str.is_a?(String)
          str
        end
      end
    end
  end
end
