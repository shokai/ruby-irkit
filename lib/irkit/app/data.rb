require 'yaml'
require 'open-uri'

module IRKit
  module App

    DATA_FILE = ENV["IRKIT_DATA_FILE"] || File.expand_path('.irkit.json', ENV['HOME'])

    if File.exists?(DATA_FILE) || DATA_FILE =~ /\A#{URI::regexp(['http', 'https'])}\z/
      Data = Hashie::Mash.new JSON.parse(open(DATA_FILE).read)
    else
      Data = Hashie::Mash.new("IR" => {}, "Device" => {})
    end

    def Data.save
      File.open DATA_FILE, "w+" do |f|
        f.write self.to_json
      end
    end

  end
end
