require 'rubygems'
require 'amqp'
require 'mq'


def start_consumer
puts "Starting consumer..."
  AMQP.start(:host => 'localhost' ) do
    q = MQ.new.queue('tasks')
    q.subscribe do |msg|
      puts "Received Message."
      yield Marshal.load(msg)
      puts "Processed Message"
    end
    puts "No more subscribe"
  end
  puts "No more amqp"
end

start_consumer do |msg|
  puts "start"
  puts msg[:type]
  puts "end"
end
puts "End."
