# IRKit

[IRKit](http://getirkit.com) Client for Ruby


## Requirements

- Ruby2.0+

## Installation

    % gem install irkit


## Usage

see [samples](https://github.com/shokai/ruby-irkit/tree/master/samples)

### Read/Write IR-Data

```ruby
require 'irkit'

irkit = IRKit::Device.find.first   # find with Bonjour
# irkit = IRKit::Device.new(address: '192.168.0.123')

unless irkit
  STDERR.puts 'device not found'
  exit 1
end

ir_data = irkit.get_messages
unless ir_data
  STDERR.puts 'IR data not found'
  exit 1
end

p ir_data

puts 'rewrite IR data'
irkit.post_messages ir_data
```


### Internet API

get `clientkey` and `deviceid`

```ruby
irkit = IRKit::Device.find.first

unless irkit
  STDERR.puts 'device not found'
  exit 1
end

token = irkit.get_token
puts "token: #{token}"
res = irkit.get_key_and_deviceid(token)

puts "clientkey:#{res.clientkey}"
puts "deviceid:#{res.deviceid}"
```

Read/Write with Internet API

```ruby
irkit = IRKit::InternetAPI.new(clientkey: "your-clientkey", deviceid: "your-deviceid")

unless irkit
  STDERR.puts 'device not found'
  exit 1
end

p irkit

unless ir_data = irkit.get_messages
  STDERR.puts 'IR data not found'
  exit 1
end

p ir_data.message

puts 'rewrite IR data'
irkit.post_messages ir_data.message
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
