require "em-http"
req 'lib/srv/init'

module KaruiOshaberi
  class IconSrv

    def initialize(service)
      service = "none" if service.nil?
      @service = KaruiOshaberi::const_get(service.capitalize).new
    end

    def username(u)
      @service.username(u)
    end

    def icon()
      @service.getIcon
    end

  end
end

