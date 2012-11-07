$LOAD_PATH << File.dirname(__FILE__)

require 'application'

App.set :run, false

use Rack::Deflater
run App

