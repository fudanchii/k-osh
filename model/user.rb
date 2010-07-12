req 'lib/services'
module KaruiOshaberi
  class User < Sequel::Model
    one_to_many :dialogues
    many_to_one :channels

    def self.auth(user, pass, svc)
      service = KaruiOshaberi::ServicesProxy.new(svc)
      authuser = nil
      unless service.nil?
        service.credential user, pass
        auth = service.auth
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
