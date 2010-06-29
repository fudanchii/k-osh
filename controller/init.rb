# Define a subclass of Ramaze::Controller holding your defaults for all
# controllers
module KaruiOshaberi
  class Controller < Ramaze::Controller
    helper :xhtml
    engine :Etanni

    @user = nil;
    @channel = nil;

    private

    def channel_exists?(chan)
      Channel[:name => chan]
    end

    def nick_available?(nick)
      User[:nick => nick]
    end

  end
end
# Here go your requires for subclasses of Controller:
req 'controller/main'
req 'controller/channel'
req 'controller/user'
