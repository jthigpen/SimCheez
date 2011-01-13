require 'amqp'
require 'mq'

class String
   def underscore
       self.gsub(/::/, '/').
       gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
       gsub(/([a-z\d])([A-Z])/,'\1_\2').
       tr("-", "_").
       downcase
   end
end


class AssetMessage
  attr_reader :asset_id
  attr_reader :type

  def initialize(asset_id)
    @asset_id = asset_id
    @type = self.type
  end

  def type
    self.class.to_s.gsub(/Message/, "").underscore
  end
end

class AssetCreatedMessage < AssetMessage
end

class UploadAssetMessage < AssetMessage
end

class MessageHandler 
  def handle(msg)
    #puts "Handling #{msg}"
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
    @q.publish(Marshal.dump(message))
  end
end
