module KaruiOshaberi
  class Feature < Sequel::Model
    many_to_many :channels
  end
end
