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
  }

  get '/' do
    cache_control :public, :must_revalidate, :max_age => 3600
    last_modified Date.today
    body = haml :index
    etag Digest::MD5.hexdigest(body)
    body
  end

  get '/*' do
    redirect '/', 301
  end

end
