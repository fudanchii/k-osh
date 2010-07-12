require 'net/https'

module KaruiOshaberi
  class Plurk < Service
    
    @@api_key = "RxeV3pAOSRW9X77OEjMXbf5CCUmiOmK4";
    @@url = "www.plurk.com/API"
    @@icon_url = "http://avatars.plurk.com"
    
    def auth
      result = nil
      furl = http(@@url, true)+ "/Users/login" + 
      "?api_key=#{@@api_key}&username=#{@username}&password=#{@password}&no_data=1"

#      uri = URI.parse("https://www.plurk.com")
#      req = Net::HTTP.new(uri.host, uri.port)
#      req.use_ssl = true
#      req.verify_mode = OpenSSL::SSL::VERIFY_NONE
#      response = req.get(furl)
#      result = response.body if response == Net::HTTPOK

      request = EventMachine::HttpRequest.new(furl).get
      Ramaze::Current.session["login_status"] = "wait"
      request.errback { Ramaze::Current.session["login_status"] = "error"}
      request.callback {
        unless request.response_header.status >= 400
          Ramaze::Current.session["login_status"] = "ok"
        else
          Ramaze::Current.session["login_status"] = "error"
        end
      }
    end

    def getIcon
      setIcon
      @icon
    end

    private
    def setIcon
      furl = http(@@url) + "/Profile/getPublicProfile"+
      "?api_key=#{@@api_key}&user_id=#{@username}"
      request = EventMachine::HttpRequest.new(furl).get
      request.callback {
        data = JSON.parse request.response
        unless data["user_info"].nil?
          has_profile_image = data["user_info"]["has_profile_image"]
          uid = data["user_info"]["uid"]
          avatar = data["user_info"]["avatar"]
          if has_profile_image
            if avatar.nil? or avatar == "0"
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
