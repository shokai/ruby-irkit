$:.unshift File.expand_path '../lib', File.dirname(__FILE__)

require 'irkit'

CLIENT_KEY = ENV["CLIENT_KEY"] || "your_client_key"
DEVICE_ID  = ENV["DEVICE_ID"]  || "your_device_id"

device = IRKit::InternetAPI.new(clientkey: CLIENT_KEY, deviceid: DEVICE_ID)
unless device
  STDERR.puts 'device not found'
  exit 1
end

p device

unless ir_data = device.get_messages
  STDERR.puts 'IR data not found'
  exit 1
end

p ir_data.message

puts 'rewrite IR data'
p device.post_messages ir_data.message
