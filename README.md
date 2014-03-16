# IRKit

[IRKit](http://getirkit.com) Client for Ruby


## Requirements

- Ruby2.0+
- Mac OSX or Linux


## Installation

for Mac

    % gem install irkit

for Debian/Ubuntu Linux

    % sudo apt-get install libavahi-compat-libdnssd-dev
    % gem install irkit

## irkit command

    % irkit --help
    % irkit --get  tv_on
    % irkit --post tv_on
    % irkit --post tv_on --address 192.168.0.123
    % irkit --list
    % irkit --delete tv_on

use Internet API

    % irkit --device:add myhouse
    % irkit --post tv_on --device myhouse
    % irkit --device:delete myhouse


## Usage

see [samples](https://github.com/shokai/ruby-irkit/tree/master/samples)

### Read/Write IR-Data

IRKit has a HTTP-API that can be used from within the same LAN.

```ruby
require 'irkit'

## find IRKit with Bonjour
irkit = IRKit::Device.find.first

## or, specify with IP-Address
irkit = IRKit::Device.new(address: '192.168.0.123')

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


### Internet-API

To access IRKit from outside of the LAN, use Internet-API.
It uses api.getirkit.com as a proxy.


Get `clientkey` and `deviceid`

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


Read/Write with Internet-API

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
