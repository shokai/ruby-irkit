$:.unshift File.expand_path '../lib', File.dirname(__FILE__)

require 'irkit'

device = IRKit::Device.find.first
# device = IRKit::Device.new '192.168.1.112'
unless device
  STDERR.puts 'device not found'
  exit 1
end

p device

unless ir_data = device.get_messages
  STDERR.puts 'IR data not found'
  exit 1
end

p ir_data

puts 'rewrite IR data'
p device.post_messages ir_data
