req 'lib/services'
module KaruiOshaberi
  class User < Sequel::Model
    one_to_many :dialogues
    many_to_one :channels

    def getIcon(user, svc)
      service = KaruiOshaberi::ServicesProxy.new(svc)
      service.credential user
      return service.icon
    end

    def self.auth(user, pass, svc)
      service = KaruiOshaberi::ServicesProxy.new(svc)
      unless service.nil?
        service.credential user, pass
        service.auth
        if Ramaze::Current.session["login_status"] == "redirect"
          return "redirect"
        end
        if Ramaze::Current.session["login_status"] == "ok"
          authuser = User[:nick => user]
          if authuser.nil?
            authuser = User.create(:nick => user)
            authuser.icon = service.icon
          end
        end
      end
      authuser
    end

  end
end
