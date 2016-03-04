# Rubocop::Rails::OrderModelDeclarativeMethods

[![Gem Version](https://badge.fury.io/rb/rubocop-rails-order_model_declarative_methods.svg)](https://badge.fury.io/rb/rubocop-rails-order_model_declarative_methods)
[![Build Status](https://travis-ci.org/pocke/rubocop-rails-order_model_declarative_methods.svg?branch=master)](https://travis-ci.org/pocke/rubocop-rails-order_model_declarative_methods)


Sort declarative methods of Rails model, as an extension to [RuboCop](https://github.com/bbatsov/rubocop).

## What's this?

### Bad code

```ruby
class User < ActiveRecord::Base
  belongs_to :plan
  validate :validate_name
  after_create :after_create_1
  has_many :messages
  attr_readonly :email
  after_create :after_create_2
  belongs_to :role
  before_create :set_name
end
```

Declarative methods are not sorted...


### Run `rubocop --auto-correct`

```ruby
class User < ActiveRecord::Base
  belongs_to :plan
  belongs_to :role
  has_many :messages

  validate :validate_name
  before_create :set_name
  after_create :after_create_1
  after_create :after_create_2

  attr_readonly :email

end
```

- Group by `associations`, `callbacks`, and others.
- Sort by execution order if it's callback method.


## Installation

Just install the `rubocop-rails-order_model_declarative_methods` gem.

```sh
gem install rubocop-rails-order_model_declarative_methods
```

or if you use `bundler` put this in your `Gemfile`.

```ruby
gem 'rubocop-rails-order_model_declarative_methods'
```


## Usage

### RuboCop configuration file

Put this into your `.rubocop.yml`.

```yaml
require: rubocop-rails-order_model_declarative_methods
```


### Command line

```sh
rubocop --require rubocop-rails-order_model_declarative_methods
```

### Rake task

```ruby
RuboCop::RakeTask.new do |task|
  task.requires << 'rubocop-rails-order_model_declarative_methods'
end
```



## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## Links

- [Rails のモデル内のメソッドをソートするRubocop Extension を作った - pockestrap](http://pocke.hatenablog.com/entry/2016/03/04/232425) (Japanese Blog)


## License

These codes are licensed under CC0.

[![CC0](http://i.creativecommons.org/p/zero/1.0/88x31.png "CC0")](http://creativecommons.org/publicdomain/zero/1.0/deed.en)
