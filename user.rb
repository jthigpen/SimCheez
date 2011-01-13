require 'rubygems'
require './simcheez'

AMQP.start(:host => 'localhost') do
  def publish(msg)
    MQ.queue('tasks').publish(Marshal.dump(msg))
  end

  EM.add_periodic_timer(1){
    msg = UploadAssetMessage.new
    puts "Publishing Image #{msg.asset_id}"
    publish msg
  }
end
