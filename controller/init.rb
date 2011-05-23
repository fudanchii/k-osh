# Define a subclass of Ramaze::Controller holding your defaults for all
# controllers
module KaruiOshaberi
  class Controller < Ramaze::Controller
    helper :xhtml
    engine :Etanni

    def not_found
    end

    private

    def inotify(channel, target, message)
      d = Dialogue.create(:context => "notification", :target => target, :ct => message, :time_stamp => Time.now)
      channel.add_dialogue(d)
    end

    def channel_exists?(chan)
      !!(Channel[:name => chan])
    end

    def has_login?(nick)
      user = User[:nick => nick]
      unless user.nil?
        return user.channel_id
      end
    end

    def self.action_missing(path)
      try_resolve '/not_found'
    end

  end
end
# Here go your requires for subclasses of Controller:
req 'controller/main'
req 'controller/channel'
req 'controller/user'
