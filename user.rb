require 'rubygems'
require 'amqp'
require 'mq'

  AMQP.start(:host => 'localhost') do

  def publish(msg)
    MQ.queue('tasks').publish(Marshal.dump(msg))
  end

EM.add_periodic_timer(1){
  asset_id = Random.new.rand(1..10000)
  puts "Publishing Image #{asset_id}"
  msg = {:type => "asset.upload", :asset_id => asset_id} 
  publish msg
}
end
