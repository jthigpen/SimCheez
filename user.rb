require 'rubygems'
require 'amqp'
require 'mq'

def publish(msg)
  AMQP.start(:host => 'localhost') do
    MQ.queue('tasks').publish(Marshal.dump(msg))
    AMQP.stop { EM.stop }
  end
end

asset_id = Random.new.rand(1..10000)
msg = {:type => "asset.upload", :asset_id => asset_id} 
publish(msg)
