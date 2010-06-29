module KaruiOshaberi
  class CSystem < FeatureSet
    
    def join(channel)
      chan = Channel[:name => channel]
      user = User[:nick => @user]
      if chan.nil?
        chan = Channel.create(:name => channel, :creator => @user)
        chan.add_feature(Feature[:name => "CSystem"])
      end
      chan.add_user(user)
      user.offset = 0
      user.save
      msg = "Now talk on #{channel}. #{chan.users.length} users online"
      result = Dialogue.create(:ct => msg, :target => @user, :context => "notification", :time_stamp => Time.now)
      chan.add_dialogue(result)
      result
    end

    def info()
      ch = Channel[:name => @channel]
      msg = "#{@channel} is about #{ch.topic}, created by #{ch.creator}.</br>#{ch.users.length} users currently online."
      result = Dialogue.create(:ct => msg, :target => @user, :context => "notification", :time_stamp => Time.now)
      ch.add_dialogue(result)
      result
    end

    def about()
      ch = Channel[:name => @channel]
      msg = "Karui Oshaberi, http based chat platform.
the main goal of this project is to provide irc like environment for the web. Yet, not purposed to replace irc.
Chat, and be friendly."
      result = Dialogue.create(:ct => msg, :target => @user, :context => "notification", :time_stamp => Time.now)
      ch.add_dialogue(result)
      result
    end

    def whois(nick)
    end

    def help(cmd)
    end

    def msg(nick,msg)
    end

  end
end
