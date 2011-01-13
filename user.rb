require 'rubygems'
require './simcheez'

def publish_message(message)
  AMQP.start(:host => 'localhost' ) do
    q = MQ.new.queue('tasks')
    q.publish(message)
  end
end

AMQP.start(:host => 'localhost') do
  def publish(msg)
    MQ.queue('tasks').publish(Marshal.dump(msg))
  end

  EM.add_periodic_timer(1){
    msg = UploadAssetMessage.new
    puts "Publishing Image #{msg.asset_id}"
    publish_message msg
  }
end
