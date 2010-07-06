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
      ch = Channel[@channel]
      msg = "#{@user} has left, #{ch.users.length} user(s) online."
      ch.add_dialogue(Dialogue.create(:ct => msg, :target => "all", :context => "notification", :time_stamp => Time.now))
      msg = "#{user.nick} has joined #{channel}, #{chan.users.length} user(s) online"
      result = Dialogue.create(:ct => msg, :target => "all", :context => "notification", :time_stamp => Time.now)
      chan.add_dialogue(result)
      result
    end

    def info()
      ch = Channel[@channel]
      msg = "#{ch.name} is about #{ch.topic}, created by #{ch.creator}, currently #{ch.users.length} users online."
      result = Dialogue.create(:ct => msg, :target => @user, :context => "notification", :time_stamp => Time.now)
      ch.add_dialogue(result)
      result
    end

    def about()
      ch = Channel[@channel]
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

    def pm(nick,msg)
      ch = Channel[@channel]
      result = Dialogue.create(:ct => msg, :target => nick, :time_stamp => Time.now)
      ch.add_dialogue(result)
      result
    end

    def nick(nick)
      ch = Channel[@channel]
      user = User[:nick => nick]
      if user.nil?
        user = User[:nick => @user]
        user.update(:nick => nick)
        Current.session[:credential][:user] = user.nick
        msg = "#{@user} now known as #{user.nick}."
        result = Dialogue.create(:ct => msg, :time_stamp => Time.now, :context => "notification")
        ch.add_dialogue(result)
        return result
      end
      nil
    end

  end
end
