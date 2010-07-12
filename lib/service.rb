module KaruiOshaberi
  class Service

    def initialize
      @icon = "/icon/default.png"
    end

    def username(u)
      @username = u
    end

    def password(p)
      @password = p
    end

    def http(url, secure = false)
      if secure
        return "https://" + url
      end
      return "http://" + url
    end
    
  end 
end

req 'lib/srv/init'
