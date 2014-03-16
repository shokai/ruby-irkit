$:.unshift File.expand_path '../lib', File.dirname(__FILE__)

require 'irkit'

unless irkit = IRKit::Device.find.first
  STDERR.puts 'device not found'
  exit 1
end

token = irkit.get_token
puts "token:\t#{token}"
res = irkit.get_key_and_deviceid(token)

puts "clientkey:\t#{res.clientkey}"
puts "deviceid:\t#{res.deviceid}"
