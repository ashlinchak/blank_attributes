require 'active_record'

module BlankAttributes
  if defined?(ActiveRecord::Base)
    require 'blank_attributes/version'
    require 'blank_attributes/blankable'

    ActiveRecord::Base.extend BlankAttributes::Blankable
  end
end
