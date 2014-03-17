module IRKit
  class Device

    attr_accessor :address, :bonjour_name

    def initialize(address: nil)
      @address = address
    end

    def url
      "http://#{@address}"
    end

    def to_s
      inspect
    end

    def get_messages
      res = HTTParty.get("#{url}/messages")
      case res.code
      when 200
        return nil if res.body.length < 1
        return IRKit::Response.new JSON.parse res.body
      else
        raise IRKit::Error, res.body
      end
    end

    def post_messages(data)
      opts = {
        :body => data.to_json
      }
      HTTParty.post "#{url}/messages", opts
    end

    def get_token
      res = HTTParty.post "#{url}/keys", {}
      case res.code
      when 200
        return JSON.parse(res.body)["clienttoken"]
      else
        raise IRKit::Error, res.body
      end
    end

    def get_key_and_deviceid(clienttoken)
      raise ArgumentError, "token must be String" unless clienttoken.kind_of? String
      opts = {
        :body => {
          :clienttoken => clienttoken
        }
      }
      res = HTTParty.post "http://api.getirkit.com/1/keys", opts
      case res.code
      when 200
        return IRKit::Response.new JSON.parse(res.body)
      else
        raise IRKit::Error, res.body
      end
    end

  end
end
