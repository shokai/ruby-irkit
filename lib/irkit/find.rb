module IRKit

  def self.find(&block)
    hosts = []
    DNSSD.browse '_irkit._tcp' do |reply|
      next unless reply.name =~ /irkit/
      addrs = Socket.getaddrinfo("#{reply.name}.local.", nil, Socket::AF_INET)
      hosts.push addrs[0][2] rescue next
    end
    5.times do
      sleep 1
      break unless hosts.empty?
    end
    return hosts
  end

end
