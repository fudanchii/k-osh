module KaruiOshaberi
  class Twitter
    
    @@url = "http://api.twitter.com/1/"
    @@XLIMIT = 1;
    
    def initialize
      @icon = "/icon/default.png";
    end

    def username(name)
      @username = name
    end

    def getIcon
      setIcon
      @icon
    end

    private
    def setIcon
      furl = @@url + "users/profile_image/" + @username + ".xml"
      request = EventMachine::HttpRequest.new(furl).get
      request.callback {
        @icon = request.response_header.location
        user = User[:nick => @username]
        user.icon = @icon
        user.save 
      }
    end
     
  end
end
