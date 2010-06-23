module KaruiOshaberi
  class UserController < Controller
    map '/user'
    
    before_all { redirect '/' unless request.xhr? }

    def add
      user = User[:nick => request[:nick]]
      unless user.nil?
        User.create(:nick => request[:nick])
      end
    end

    def get
      user = User[:nick => request[:user]]
      session[:credential][:user] = user.nick
    end

  end
end
