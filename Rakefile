require 'dotenv/tasks'

task :deploy => :dotenv do
  sh "scp -rp build/* #{ENV['PRODUCTION_SERVER']}"
  sh "git push"
end

