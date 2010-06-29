module KaruiOshaberi
  class Dialogue < Sequel::Model
    many_to_one :channel
    many_to_one :user


    def to_json(*o)
      user = User[user_id]
      {
        :content => 
        {
           :ct => ct,
           :user => user.nick,
           :icon => user.icon,
           :context => context,
           :time_stamp => time_stamp
        },
        :f => "function(data){ proc_#{context}(data); }"
      }.to_json(*o)
    end
  end
end
