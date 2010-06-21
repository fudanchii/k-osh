# This file contains your application, it requires dependencies and necessary
# parts of the application.
#
# It will be required from either `config.ru` or `start.rb`

require 'rubygems'
require 'ramaze'

# Make sure that Ramaze knows where you are
Ramaze.options.roots = [__DIR__]

def load(mod)
  require __DIR__(mod)
end

# Initialize controllers and models
load 'model/init'
load 'controller/init'
