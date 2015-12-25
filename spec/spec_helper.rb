$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')

require 'bundler/setup'
require 'blank_attributes'
require 'pry-byebug'

ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")

ActiveRecord::Schema.define(version: 1) do
  create_table :users do |t|
    t.string :name
    t.string :email
    t.integer :age
    t.text :description
    t.timestamps
  end
end

RSpec.configure do |config|
end

class User < ActiveRecord::Base
  attr_accessor :profile_ids
  blank_attributes :name, :profile_ids

  class << self
    # Imitate an array type
    def columns_hash
      columns_in_hash = super()
      columns_in_hash['profile_ids'] = OpenStruct.new(array: true)
      columns_in_hash
    end
  end
end


def clean_database
  models = [User]
  models.each do |model|
    ActiveRecord::Base.connection.execute "DELETE FROM #{model.table_name}"
  end
end
