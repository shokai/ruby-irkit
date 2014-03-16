$:.unshift File.expand_path '../lib', File.dirname(__FILE__)

require 'irkit'

irkit = IRKit::Device.find.first
# irkit = IRKit::Device.new(address: '192.168.1.112')
unless irkit
  STDERR.puts 'device not found'
  exit 1
end

p irkit

unless ir_data = irkit.get_messages
  STDERR.puts 'IR data not found'
  exit 1
end

p ir_data

puts 'rewrite IR data'
p irkit.post_messages ir_data
