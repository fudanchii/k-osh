module KaruiOshaberi
  class MainController < Controller
    map '/'
    layout :default

    before_all { @inside_index = false }

    def index
      @inside_index = true
      @title = "かるい-おしゃべり"
      @disabled = ""
      @nickform = a 'logout', r(:logout)
      if request.post? and !request[:nick].nil?
        unless has_login? request[:nick]
          unless login
            flash[:error] = "can not login"
          end
        else
          flash[:error] = "nickname already taken"
        end
      end
      if session[:credential].nil?
        @disabled = "disabled"
        @nickform = render_view :login
      end
    end

    def login
      redirect '/' unless @inside_index
      user = User.auth(request[:nick], request[:passwd], request[:service])
      unless user.nil?
        channel = Channel[:name => "Main"]
        channel.add_user(user)
        msg = "#{user.nick} has joined Main channel, #{channel.users.length} user(s) online."
        inotify(channel, "all", msg)
        session[:credential] = { :user => user.nick, :icon => user.icon }
      end
      session[:credential]
    end

    def logout
      redirect '/' if session[:credential].nil?
      user = User[:nick => session[:credential][:user]]
      channel = Channel[user.channel_id]
      channel.remove_user(user)
      inotify(channel, "all", "#{user.nick} has left, #{channel.users.length} user(s) online.")
      session.clear
      redirect '/'
    end

  end
end
