require "sequel"

Sequel.extension :migration

module KaruiOshaberi
  DB = Sequel.sqlite
  #DB = Sequel.connect("postgres://gencore:tr4pp4r@localhost/genshiken")
end

req 'lib/migrate'

# Here go your requires for models:
# require 'model/user'
req 'model/channel'
req 'model/dialogue'
req 'model/user'
req 'model/feature'
