module IRKit

  class Device

    def self.find(&block)
      hosts = []
      DNSSD.browse '_irkit._tcp' do |reply|
        next unless reply.name =~ /irkit/
        addrs = Socket.getaddrinfo("#{reply.name}.local.", nil, Socket::AF_INET)
        hosts.push IRKit::Device.new(addrs[0][2], reply.name) rescue next
      end
      5.times do
        sleep 1
        break unless hosts.empty?
      end
      return hosts
    end

  end

end
