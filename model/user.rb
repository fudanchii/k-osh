req 'lib/iconsrv'
module KaruiOshaberi
  class User < Sequel::Model
    one_to_many :dialogues
    many_to_one :channels

    def getIcon(service)
      srv = KaruiOshaberi::IconSrv.new(service)
      srv.username(nick)
      srv.icon
    end

    def to_json(*a)
      {
         :nick => nick,
         :icon => icon
      }.to_json(*a)
    end

  end
end
