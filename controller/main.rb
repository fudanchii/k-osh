module KaruiOshaberi
  class MainController < Controller
    map '/'
    layout :default

    before_all {@inside_index = false}

    def index
      @inside_index = true
      @title = "かるい-おしゃべり"
      @disabled = ""
      @nickform = a 'logout', r(:logout)
      if request.post? and !request[:nick].nil?
        unless nick_available? request[:nick]
          login
        else
          @errmsg = "nickname already taken"
        end
      end
      if session[:credential].nil?
        @disabled = "disabled"
        @nickform = render_view :login
      end
    end
    
    def login
      redirect '/' unless @inside_index
      user = User.create(:nick => request[:nick])
      channel = Channel[:name => "Main"]
      channel.add_user(user)
      icon = user.getIcon(request[:service])
      user.icon = icon
      user.save
      session[:credential] = { :user => user.nick, :icon => user.icon }
    end

    def logout
      redirect '/' if session[:credential].nil?
      session[:credential] = nil
      redirect '/'
    end

  end
end
