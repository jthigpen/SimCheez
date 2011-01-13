require 'rubygems'
require 'amqp'
require 'mq'

AMQP.start(:host => 'localhost') do
 MQ.queue('tasks').publish(Marshal.dump({:type => 1, :body => "foo"}))
 AMQP.stop { EM.stop }
end

