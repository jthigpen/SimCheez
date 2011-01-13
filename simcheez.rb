require 'amqp'
require 'mq'

class AssetMessage
  attr_reader :asset_id
  attr_reader :type
end

class AssetCreatedMessage < AssetMessage
  def initialize(asset_id)
    @asset_id = asset_id
    @type = :asset_created
  end
end

class UploadAssetMessage < AssetMessage
  def initialize
    @asset_id = Random.new.rand(1..10000)
    @type = :asset_upload
  end
end

class MessageHandler 
  def handle(msg)
    puts "Handling #{msg}"
    self.send(msg.type, msg) if self.respond_to? msg.type
  end

  def start_consuming_messages
    AMQP.start(:host => 'localhost' ) do
      @q = MQ.new.queue('tasks')
      @q.subscribe do |msg|
        begin
          marshalled_message = Marshal.load(msg)
          self.handle(marshalled_message)
        rescue
          puts "Oh shit: #{msg}"
        end
     end
    end
  end
  
  def publish(message)
    @q.publish(message)
  end
end

