require 'dotenv'
Dotenv.load

require 'haml'
require 'base64'

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

  def render(partial)
    Haml::Engine.new(File.read("src/_#{partial}.haml")).render
  end

end

