# IRKit

[IRKit](http://getirkit.com) Client for Ruby


## Installation

    % gem install irkit


## Usage

```ruby
require 'irkit'

device = IRKit::Device.find.first   # find device with Bonjour
# device = IRKit::Device.new '192.168.1.112'
unless device
  STDERR.puts 'device not found'
  exit 1
end

p device

ir_data = device.get_messages
unless ir_data
  STDERR.puts 'IR data not found'
  exit 1
end

p ir_data

puts 'rewrite IR data'
p device.post_messages ir_data
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
