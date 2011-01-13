require 'rubygems'
require './simcheez.rb'

def random_asset_id
  Random.new.rand(1..10000)
end

AMQP.start(:host => 'localhost') do
  def publish_message(msg)
    MQ.queue('tasks').publish(Marshal.dump(msg))
  end

  EM.add_periodic_timer(1){
    msg = UploadAssetMessage.new(random_asset_id)
    puts "Publishing Image #{msg.asset_id}"
    publish_message msg
  }
end
