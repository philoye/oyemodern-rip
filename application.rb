require 'bundler'
ENV['RACK_ENV'] = 'development' unless ENV['RACK_ENV']
Bundler.require(:default, ENV['RACK_ENV'])

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

  register Sinatra::CompassSupport
  register Sinatra::AssetPack
  register Sinatra::Partial
  enable :partial_underscores

  configure :development do |config|
    require "sinatra/reloader"
    register Sinatra::Reloader
  end

  assets {
    serve '/images', from: 'app/images'
    serve '/js',     from: 'app/js'
    serve '/css',    from: 'app/css'

    js :'jsforhead', [
      '/js/vendor/modernizr.js',
      '/js/vendor/respond.js'
    ]
    js :application, [
      '/js/vendor/jquery.js',
      '/js/vendor/underscore.js',
      '/js/vendor/console.js',
      '/js/application.js'
    ]
    css :application, [
      '/css/*.css'
    ]
    expires 86400*365, :public
  }

  get '/' do
    cache_control :public, :must_revalidate, :max_age => 3600
    haml :index
  end

  get '/*' do
    redirect '/', 301
  end

end
