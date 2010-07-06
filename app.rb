# Our bootstrap, start up the app
# 
#  Copyright 2010 Nurahmadie <nurahmadie@gmail.com>

require 'rubygems'
require 'ramaze'
require 'json'

# Make sure that Ramaze knows where you are
Ramaze.options.roots = [__DIR__]

##Routing section
Ramaze::Route[%r!^/(talk|poll)$!] = "/channel/%s"
##

# Define our require method to make things easier
def req(mod)
  require __DIR__(mod)
end

# Initialize controllers and models
req 'model/init'
req 'controller/init'
