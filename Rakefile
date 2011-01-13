require 'rake'

namespace :queues do
  task :flush do
    sh 'rabbitmqctl stop_app'
    sh 'rabbitmqctl reset'
    sh 'rabbitmqctl start_app'
  end
end
