module KaruiOshaberi
  class Js
    map '/js'
    layout :none

    before_all { redirect '/not_found' if not_valid request["jstoken"] }

    def auth(service)
    end

    private
    def not_valid(token)
      if session["jstoken"].nil?
        session["jstoken"] = KaruiOshaberi::TokenFactory.generate
      end
    end

  end
end
