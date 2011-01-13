require 'rubygems'
require 'amqp'
require 'mq'

def publish(msg)
  AMQP.start(:host => 'localhost') do
    MQ.queue('tasks').publish(Marshal.dump(msg))
  AMQP.stop { EM.stop }
  end
end

while true do
  asset_id = Random.new.rand(1..10000)
  puts "Uploading Image #{asset_id}"
  publish({:type => "asset.upload", :asset_id => asset_id})
  sleep 2
end
