module IRKit

  class InternetAPI

    attr_reader :clientkey, :deviceid

    def initialize(clientkey: nil, deviceid: nil)
      raise ArgumentError, "clientkey must be String" unless clientkey.kind_of? String
      raise ArgumentError, "deviceid must be String" unless deviceid.kind_of? String
      @clientkey = clientkey
      @deviceid = deviceid
    end

    def url
      "https://api.getirkit.com/1"
    end

    def to_s
      %Q{<#{self.class} @deviceid="#{@deviceid[0..6]}XXXXX" @clientkey="#{@clientkey[0..6]}XXXXX">}
    end

    def get_messages(query={})
      opts = {
        :query => {:clientkey => @clientkey}
      }
      query.each do |k,v|
        opts[:query][k] = v
      end
      res = HTTParty.get("#{url}/messages", opts)
      case res.code
      when 200
        return nil if res.body.length < 1
        return IRKit::Response.new JSON.parse res.body
      when 401
        raise IRKit::Error, "Unauthorized"
      else
        raise IRKit::Error, res.body
      end
    end

    def post_messages(data)
      opts = {
        :body => {
          :deviceid => @deviceid,
          :clientkey => @clientkey,
          :message => data.to_json
        }
      }
      HTTParty.post "#{url}/messages", opts
    end

  end

end
