module KaruiOshaberi
  class None < Service

    def auth
      Ramaze::Current.session["login_status"] = "ok"
    end

    def getIcon
      @icon = "/icon/default.png"
      @icon
    end
  end
end
