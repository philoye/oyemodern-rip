require 'dotenv'
Dotenv.load

require 'haml'
require 'base64'
require 'sassc'
require 'coffee-script'

module Haml::Helpers
  
  def svg_use_tag(id, klass={})
    haml_tag :svg, :class => klass do
      haml_tag :use, "xlink:href"=>id
    end
  end

  def inline_svg(filename)
    path = File.join("src/#{filename}.svg")
		File.read(path)
  end

  def inline_jpeg(filename, width, height, classname='' )
    path = File.join("src/#{filename}.jpg")
    data = Base64.encode64(open(path).to_a.join)
    haml_tag :img, src: "data:image/jpeg;base64,#{data}", alt: filename, class: classname, width: width, height: height
  end

  def img_asset_path(filename)
    return "images/#{filename}"
  end

  def render(partial, locals = {})
    Haml::Engine.new(File.read("src/_#{partial}.haml")).render(Object.new, locals)
  end

  def inline_css(file)
    template = File.read("src/styles/#{file}.sass")
    SassC::Engine.new(template, :syntax => :sass).render
  end
  
  def inline_coffee(file)
    coffee = File.read("src/scripts/#{file}.coffee")
    CoffeeScript.compile coffee
  end

  def inline_js(filenames)
    js = ""
    filenames.each {|file| js << File.read(File.join("public/scripts/vendor/#{file}.js")) }
    return js
  end

end

