module KaruiOshaberi
  class Dialogue < Sequel::Model
    many_to_one :channel
    many_to_one :user


    def to_json(*o)
      user = User[user_id]
      if user.nil?
        nick = "none"
        icon = "none"
      else
        nick = user.nick
        icon = user.icon
      end
      {
        :content => 
        {
           :ct => ct,
           :user => nick,
           :icon => icon,
           :context => context,
           :time_stamp => time_stamp
        }
      }.to_json(*o)
    end
  end
end
