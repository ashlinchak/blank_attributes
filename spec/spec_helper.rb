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
  blank_attributes :name
end

def clean_database
  models = [User]
  models.each do |model|
    ActiveRecord::Base.connection.execute "DELETE FROM #{model.table_name}"
  end
end
