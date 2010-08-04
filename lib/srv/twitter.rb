require 'oauth'
require 'oauth/consumer'


module KaruiOshaberi
  class Twitter < Service
    
    APIURL = ENV["APIGEE_TWITTER_API_ENDPOINT"] || "api.twitter.com"

    @@url = {:futsuu => "http://"+APIURL,
             :secure => "https://"+APIURL }

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
      })

      Ramaze::Current.session["request_token"] = 
      consumer.get_request_token({:oauth_callback => "https://k-osh.heroku.com/oauthcallback/twitter"})

      Ramaze::Current.session["login_status"] = "redirect"
    end
    
    def getIcon
      setIcon
      @icon
    end

    private
    def setIcon
      furl = @@url[:futsuu] + "/1/users/profile_image/" + @username + ".xml"
      EventMachine.run {
        request = EventMachine::HttpRequest.new(furl).get
        request.callback {
          @icon = request.response_header.location
          user = User[:nick => @username]
          user.icon = @icon
          user.save 
        }
      }
    end
     
  end
end
