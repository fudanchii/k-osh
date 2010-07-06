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
          login
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
      user = User[:nick => request[:nick]]
      if user.nil?
        user = User.create(:nick => request[:nick])
      end
      channel = Channel[:name => "Main"]
      channel.add_user(user)
      inotify(channel, "all", "#{user.nick} has joined Main channel, #{channel.users.length} user(s) online.")
      icon = user.getIcon(request[:service])
      user.icon = icon
      user.save
      session[:credential] = { :user => user.nick, :icon => user.icon }
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
