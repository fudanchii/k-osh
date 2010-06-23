module KaruiOshaberi
  class ChannelController < Controller
    map '/channel'
    layout :none

    before_all { redirect '/' unless request.xhr? }

    def index
      @channels = Channel.all
    end

    def create
      channel = Channel[:name => request[:channel]]
      redirect '/channel/join' unless channel.nil?
      Channel.create(:name => request[:channel])
    end

    def join
      channel = Channel[:name => request[:channel]]
      channel.add_user(User.create(request[:nick]))      
    end

    def poll
      if session[:offset].nil?
        session[:offset] = 0;
      end
      chan = "Main"
      channel = Channel[:name => chan]
      if channel.nil?
        channel = Channel.create(:name => chan)
      end
      @result = channel.dialogues[session[:offset]..-1]
      if session[:offset] > 1 and @result.length == session[:offset]
        puts session[:offset]
        @result = nil
        return
      end
      session[:offset] = session[:offset] + @result.length;
    end

    def talkto(chan)
      return unless channel_exists?(chan)
      unless request[:cmdtext].nil?
        return if request[:cmdtext].strip == ""
      end
      channel = Channel[:name => chan]
      channel.add_dialogue(Dialogue.create(:content => request[:cmdtext], :nick => request[:user]))
    end

  end
end
