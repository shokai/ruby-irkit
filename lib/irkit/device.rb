module IRKit
  class Device

    attr_reader :addr, :bonjour_name

    def initialize(addr, bonjour_name=nil)
      @addr = addr
      @bonjour_name = bonjour_name
    end

    def get_messages
      res = HTTParty.get("http://#{@addr}/messages")
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
      HTTParty.post "http://#{@addr}/messages", opts
    end

    def get_token
      res = HTTParty.post "http://#{@addr}/keys", {}
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
