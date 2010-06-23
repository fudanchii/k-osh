module KaruiOshaberi
  class User < Sequel::Model
    one_to_many :dialogues
    many_to_many :channels
  end
end
