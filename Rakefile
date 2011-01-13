require 'rake'

namespace :queues do
  task :flush do
    sh 'rabbitmqctl stop_app'
    sh 'rabbitmqctl reset'
    sh 'rabbitmqctl start_app'
  end
end

task :default do
  sh 'ruby wordpress.rb &'
  sh 'ruby moderator.rb &'
  sh 'ruby mine.rb &'
  sh 'ruby user.rb &'
end

task :user do 
  sh 'ruby user.rb'
end

task :mine do 
  sh 'ruby mine.rb'
end

task :moderator do 
  sh 'ruby moderator.rb'
end

task :wordpress do 
  sh 'ruby wordpress.rb'
end
