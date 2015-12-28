# BlankAttributes

Blankable attributes for the ActiveRecord model.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'blank_attributes'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install blank_attributes

## Usage

```ruby
class User < ActiveRecord::Base
  blank_attributes :name, :email
end
```
And use it:

```ruby
user = User.new(name: '', email: ' ', token: ' ')
user.valid?
user.name # => nil
user.email # => nil
user.token # => " "
```
For preparing values there is used the `before_valid` callback.
## Support Types
- String
```ruby
"" # => nil
" " # => nil
```
- Array
```ruby
[""] # => []
[" "] # => []
["", 1] # => [1]
```
## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/blank_attributes.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
