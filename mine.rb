require 'rubygems'
require 'amqp'
require 'mq'

def handle_message(msg)
  puts msg[:type], msg[:asset_id]
end

AMQP.start(:host => 'localhost' ) do
 q = MQ.new.queue('tasks')
 q.subscribe do |msg|
   handle_message Marshal.load(msg)
 end
end
