require 'rubygems'
require 'amqp'
require 'mq'


AMQP.start(:host => 'localhost' ) do
 q = MQ.new.queue('tasks')
 q.subscribe do |msg|
   puts Marshal.load(msg)[:type]
 end
end
