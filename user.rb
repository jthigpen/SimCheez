require 'rubygems'
require './simcheez.rb'

message_id = 1

AMQP.start(:host => 'localhost') do
  def publish_message(msg)
    MQ.queue('tasks', {:durable => true}).publish(Marshal.dump(msg))
  end

  EM.add_periodic_timer(0.25){
    msg = AssetUploadedMessage.new(message_id)
    puts "Publishing Image #{msg.asset_id}"
    publish_message msg
    message_id = message_id + 1
  }
end
