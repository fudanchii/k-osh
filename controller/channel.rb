req 'lib/cmdproxy' 
module KaruiOshaberi
  class ChannelController < Controller
    map '/channel'
    layout :none

    before_all { redirect '/' unless request.xhr? }

    def index
      @channels = Channel.all
    end

    def poll
      session[:offset] = 0 if session[:offset].nil?
      result = []
      me = nil
      if session[:credential]
        user = User[:nick => session[:credential][:user]]
        channel = Channel[user.channel_id]
        session[:offset] = user.offset
        me = user.nick
      else
        channel = Channel[:name => "Main"]
      end
      res = channel.dialogues
      res.each do |dialogue|
        if dialogue.target == "all" or dialogue.target == me
          result << dialogue
        end
      end
      result = result[session[:offset]..-1]
      session[:offset] = session[:offset] + result.length;
      if user
        user.offset = session[:offset]
        user.save
      end
      @jsondata = result.to_json
    end

    def talk
      return "noinput" if request[:cmdtext].nil? or request[:cmdtext].strip == ""
      return "nologin" if session[:credential].nil?
      user = User[:nick => session[:credential][:user]]
      channel = Channel[user[:channel_id]]
      package = {:user => user.nick, :channel => channel.name}
      preproc = preprocess(package)
      if preproc
        "ok"
      else
        "nocommand"
      end
    end

    private
    def preprocess(pack)
      user = User[:nick => session[:credential][:user]]
      token = /^\.([a-zA-Z]+)$/.match(request[:cmdtext])
      if token.nil?
        token = /^\.([a-zA-Z]+) +(\w+)$/.match(request[:cmdtext])
      end
      if token.nil?
        token = /^\.([a-zA-Z]+) +(\w+) +(.+)$/.match(request[:cmdtext])
      end 
      if token.nil?
        di = Dialogue.create(:ct => request[:cmdtext], :time_stamp => Time.now)
        channel = Channel[user[:channel_id]].add_dialogue(di)
      else
        cmd = KaruiOshaberi::CmdProxy.new(pack)
        di = cmd.delegate token[1].downcase.to_sym, token[2..-1]
      end
      if di
        user.add_dialogue(di)
      end
      di
    end

  end
end
