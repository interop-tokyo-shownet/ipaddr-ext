# IPAddrExt

IPAddrExt provides extensions of IPAddr class.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add ipaddr-ext

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install ipaddr-ext

## Usage

```ruby
require 'ipaddr-ext'

ipaddr1 = IPAddr.new("3ffe:505:2::1")
p ipaddr1.to_s_with_prefix
#=> "3ffe:505:2::1/128"

ipaddr2 = IPAddr.new("3ffe:505:2::/64")
p ipaddr2.to_s_with_prefix
#=> "3ffe:505:2::/64"

ipaddr3 = IPAddr.new("3ffe:505:2::1")
p (ipaddr3 + 5)
#=> #<IPAddr: IPv6:3ffe:0505:0002:0000:0000:0000:0000:0006/ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff>
p (ipaddr3 + 5).to_s_with_prefix
#=> "3ffe:505:2::6/128"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/interop-tokyo-shownet/ipaddr-ext. This project is intended to be a safe, welcoming space for collaboration.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
