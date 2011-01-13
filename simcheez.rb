require 'amqp'
require 'mq'

class UploadAssetMessage
  attr_reader :type, :asset_id

  def initialize
    @asset_id = Random.new.rand(1..10000)
    @type = "asset.upload"
  end
end

def consume_messages
  AMQP.start(:host => 'localhost' ) do
   q = MQ.new.queue('tasks')
   q.subscribe do |msg|
     yield Marshal.load(msg)
   end
  end
end
