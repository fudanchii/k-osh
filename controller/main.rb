module KaruiOshaberi
  class MainController < Controller
    map '/'
    layout :default
    def index
      @title = "かるい-おしゃべり"
      @channel = "Main"
      @disabled = ""
      @user = ""
      if request.post?
        session[:credential] = { :user => request[:nick] }
      end
      if session[:credential].nil?
        @disabled = "disabled"
      else
        @user = session[:credential][:user]
      end
    end

  end
end
