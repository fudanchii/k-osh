module KaruiOshaberi
  class None < Service

    def auth
      "ok"
    end

    def getIcon
      @icon = "/icon/default.png"
      @icon
    end
  end
end
