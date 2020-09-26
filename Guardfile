# guard 'coffeescript', :input => 'src', :output => 'chrome/js'

# guard 'sass', :input => 'src', :output => './build/css'

# Sample guardfile block for Guard::Haml
# You can use some options to change guard-haml configuration
# :output => 'public'                   set output directory for compiled files
# :input => 'src'                       set input directory with haml files
# :run_at_start => true                 compile files when guard starts
# :notifications => true                send notifictions to Growl/libnotify/Notifu
# :haml_options => { :ugly => true }    pass options to the Haml engine

require './helpers'

guard 'haml', input: 'src', output: 'build' do
  watch(/^[^_][a-z]+\.haml/)
end

watch(/_{1}.+(\.haml)/) do |f|
  `touch src/[^_]*.haml`
end

watch(/.+(.sass)/) do |f|
  `touch src/*.haml`
end

guard :jammit, output_folder: 'build/scripts' do
  watch(%r{^src/scripts/vendor/(.*)\.js$})
end

coffeescript_options = {
  input:    'src/scripts',
  output:   'build/scripts',
  patterns: [%r{^src/scripts/(.+\.(?:coffee|coffee\.md|litcoffee))$}]
}

guard 'coffeescript', coffeescript_options do
  coffeescript_options[:patterns].each { |pattern| watch(pattern) }
end

guard :copy, run_at_start: true, from: 'public', to: 'build'

