module KaruiOshaberi
  class Plurk
    
    @@api_key = "RxeV3pAOSRW9X77OEjMXbf5CCUmiOmK4";
    @@url = "http://www.plurk.com/API"
    @@icon_url = "http://avatars.plurk.com"
    
    def initialize
      @icon = "/icon/default.png"
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
      furl = @@url + "/Profile/getPublicProfile?api_key=#{@@api_key}&user_id=#{@username}"
      request = EventMachine::HttpRequest.new(furl).get
      request.callback {
        data = JSON.parse request.response
        unless data["user_info"].nil?
          has_profile_image = data["user_info"]["has_profile_image"]
          uid = data["user_info"]["uid"]
          avatar = data["user_info"]["avatar"]
          if has_profile_image
            if avatar.nil?
              @icon = @@icon_url + "/#{uid}-medium.gif"
            else
              @icon = @@icon_url + "/#{uid}-medium#{avatar}.gif"
            end
          else
            @icon = @@icon_url + "/static/default-medium.gif"
          end
        end
        user = User[:nick => @username]
        user.icon = @icon
        user.save
      }
    end
  end
end
