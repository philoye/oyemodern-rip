require 'bundler'
Bundler.require

class App < Sinatra::Base

  configure do
    env = ENV["RACK_ENV"] || "development"
  end

  enable   :logging
  enable   :raise_errors
  enable   :show_exceptions if development?

  set      :root, File.dirname(__FILE__)
  set      :sass, { :load_paths => [ "#{App.root}/app/css" ] }
  set      :haml, :format => :html5

  helpers  Sinatra::ContentFor
  register Sinatra::CompassSupport
  register Sinatra::AssetPack

  register Sinatra::Partial
  enable :partial_underscores

  (
   Dir['./lib/*.rb'].sort
  ).uniq.each { |rb| require rb }

  configure :development do |config|
    require "sinatra/reloader"
    register Sinatra::Reloader
  end

  assets {
    serve '/images', from: 'app/images'
    serve '/js',     from: 'app/js'
    serve '/css',    from: 'app/css'

    js :modernizr, [
      '/js/vendor/modernizr.js'
    ]
    js :application, [
      '/js/vendor/jquery.js',
      '/js/application.js'
    ]
    css :application, [
      '/css/*.css'
    ]
  }

  get '/' do
    @email = "service".tr! "A-Za-z", "N-ZA-Mn-za-m"
    haml :index
  end

  get '/*' do
    redirect '/', 301
  end

end
