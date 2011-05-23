req 'lib/cmdproxy' 
module KaruiOshaberi
  class ChannelController < Controller
  # Channel controller, The common interface to the channel.
  # taking almost all input and output polling
  # We're only accept XMLHTTPRequest here

    map '/channel'
    layout :none

    before_all { redirect '/' unless request.xhr? }

    def index
      @channels = Channel.all
    end

    # Polling action, see if there is new data and push it to clients
    # setting data offset to the current session, make sure clients only retrieve the latest one
    def poll
      session[:offset] = 0 if session[:offset].nil?
      result = []
      if session[:credential]
        user = User[:nick => session[:credential][:user]]
        channel = Channel[user.channel_id]
        session[:offset] = user.offset
        me = user.nick
        uid = user.id
      else
        channel = Channel[:name => "Main"]
      end
      res = channel.dialogues
      res.each do |dialogue|
        if dialogue.user_id == uid or dialogue.target == "all" or dialogue.target == me
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

    # This is how we retrieve input from clients, usually via POST request
    def talk
      return "noinput" if request[:cmdtext].nil? or request[:cmdtext].strip == ""
      return "nologin" if session[:credential].nil?
      preproc = preprocess
      if preproc
        "ok"
      else
        "nocommand"
      end
    end


    private

    # Let's decide wether the request is a command or a mere plain chat
    def preprocess
      user = User[:nick => session[:credential][:user]]
      token = /^\.([a-zA-Z]+)$/.match(request[:cmdtext])
      if token.nil?
        token = /^\.([a-zA-Z]+) +(.+)$/.match(request[:cmdtext])
      end
      if token.nil?
        token = /^\.([a-zA-Z]+) +(\S+) +(.+)$/.match(request[:cmdtext])
      end 
      if token.nil?
        di = Dialogue.create(:ct => request[:cmdtext], :time_stamp => Time.now)
        channel = Channel[user[:channel_id]].add_dialogue(di)
      else
        cmd = KaruiOshaberi::CmdProxy.new
        di = cmd.delegate(token[1].downcase.to_sym, token[2..-1])
      end
      if di
        user.add_dialogue(di)
      end
      di
    end

  end
end
