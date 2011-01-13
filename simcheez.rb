require 'amqp'
require 'mq'

class UploadAssetMessage
  attr_reader :type, :asset_id

  def initialize
    @asset_id = Random.new.rand(1..10000)
    @type = :asset_upload
  end
end

def start_consuming_messages(message_handler)
  AMQP.start(:host => 'localhost' ) do
   q = MQ.new.queue('tasks')
   q.subscribe do |msg|
    marshalled_message = Marshal.load(msg)
    message_handler.handle(marshalled_message)
   end
  end
end
