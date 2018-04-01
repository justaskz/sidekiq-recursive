# Sidekiq::Recursive
Use simple recursion to limit sidekiq workers per job

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sidekiq-recursive'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sidekiq-recursive

## Usage

```ruby
class CleanUpOldUsers
  include Sidekiq::Worker
  include Sidekiq::Recursive::Worker

  recursive_worker_count 5

  def process(user_id)
    User.destroy(user_id)
  end
end

user_ids = User.where(is_old: true).ids
CleanUpOldUsers.run(user_ids)
```

#### before_all and after_all hooks
```ruby
class CleanUpOldUsers
  include Sidekiq::Worker
  include Sidekiq::Recursive::Worker

  recursive_worker_count 5
  before_all :bar
  after_all :foo

  def bar
    # do something before starting all workers
  end

  def process(user_id)
    User.destroy(user_id)
  end

  def foo
    # do something after all workers are finished
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/justaskz/sidekiq-recursive. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Sidekiq::Recursive project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/justaskz/sidekiq-recursive/blob/master/CODE_OF_CONDUCT.md).
