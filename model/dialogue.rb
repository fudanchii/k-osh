module KaruiOshaberi
  class Dialogue < Sequel::Model
    many_to_one :channel
    many_to_one :user
  end
end
