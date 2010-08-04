require 'oauth'
require 'oauth/consumer'


module KaruiOshaberi
  class Twitter < Service
    
    APIGEE = "api.twitter.com" #ENV["APIGEE_TWITTER_API_ENDPOINT"] || "twitter-api.app217352.apigee.com"

    @@url = {:futsuu => "http://"+APIGEE,
             :secure => "https://"+APIGEE }

    @@key = "0n6UfSNAVHtx3qM56A52A"
    @@secret = "TjO5dTFFOpkDARZQE8nN31pqCu1GBpVl7pvrsL0rs"
    

    def auth
      consumer = OAuth::Consumer.new(@@key, @@secret, 
      {
       :site => @@url[:secure],
       :scheme => :header,
       :http_method => :post,
       :request_token_path => "/oauth/request_token",
       :access_token_path => "/oauth/access_token",
       :authorize_path => "/oauth/authenticate",
       :oauth_callback => "http://localhost:7000/oauthcallback"
      })
      Ramaze::Current.session["request_token"] = consumer.get_request_token({:oauth_callback => "http://localhost:7000/oauthcallback"})
      #Innate::Helper::Redirect.redirect Ramaze::Current.session["request_token"].authorize_url
      Ramaze::Current.session["login_status"] = "redirect"
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
      furl = @@url[:futsuu] + "/1/users/profile_image/" + @username + ".xml"
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
