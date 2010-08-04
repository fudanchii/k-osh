require 'net/https'

module KaruiOshaberi
  class Plurk < Service
    
    @@api_key = "RxeV3pAOSRW9X77OEjMXbf5CCUmiOmK4";
    @@url = "www.plurk.com"
    @@icon_url = "http://avatars.plurk.com"
    
    def auth
      result = nil
      http = Net::HTTP.new(@@url, 443)
      http.use_ssl = true
      params = { "api_key" => @@api_key, "username" => @username, "password" => @password }
      params = Hash[*params.collect{|k, v| [k.to_s, v]}.flatten]
      request = Net::HTTP::Post.new("/API/Users/login",{})
      request.set_form_data(params)
      response = http.start { |req| req.request(request) }
      Ramaze::Current.session["login_status"] = "ok" if Net::HTTPSuccess or Net::HTTPRedirection
    end

    def getIcon
      setIcon
      @icon
    end

    private
    def setIcon
      furl = http(@@url) + "/API/Profile/getPublicProfile"+
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
