req 'lib/services'
module KaruiOshaberi
  class User < Sequel::Model
    one_to_many :dialogues
    many_to_one :channels

    def self.auth(user, pass, svc)
      service = KaruiOshaberi::ServicesProxy.new(svc)
      authuser = nil
      puts service.inspect
      unless service.nil?
        service.credential user, pass
        service.auth
        puts Ramaze::Current.session["login_status"]
        if Ramaze::Current.session["login_status"] == "ok"
          authuser = User[:nick => user]
          if authuser.nil?
            icon = service.icon
            authuser = User.create(:nick => user, :icon => icon)
          end
        end
      end
      authuser
    end

  end
end
