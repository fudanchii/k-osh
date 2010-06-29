module KaruiOshaberi
  class Channel < Sequel::Model
    one_to_many :dialogues
    one_to_many :users
    many_to_many :features
  end
end
