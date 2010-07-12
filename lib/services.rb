require "em-http"
req 'lib/service'

module KaruiOshaberi
  class ServicesProxy

    def initialize(service)
      service = "none" if service.nil?
      @service = KaruiOshaberi::const_get(service.capitalize).new
    end

    def credential(u, p)
      @service.username u
      @service.password p
    end

    def icon
      @service.getIcon
    end

    def auth
      @service.auth
    end

  end
end

