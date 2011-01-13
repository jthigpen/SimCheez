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

  def to_s
    "#{@type} - Asset: #{@asset_id}"
  end
end

class AssetCreatedMessage < AssetMessage
end

class AssetUploadedMessage < AssetMessage
end

class AssetDeniedMessage < AssetMessage
end

class AssetApprovedMessage < AssetMessage
end

class AssetFeaturedMessage < AssetMessage
end

class AssetPostedToVotePageMessage < AssetMessage
end

class AssetFeaturedOnHomepageMessage < AssetMessage
end

class PublishToVotingMessage < AssetMessage
end

class PublishToFrontPageMessage < AssetMessage
end
  
class MessageHandler 
  def handle(msg)
    #puts msg.type
    can_handle_message = self.respond_to? msg.type
    self.send(msg.type, msg) if can_handle_message
    puts "Can't handle message #{msg.type}" if !can_handle_message
    return can_handle_message
  end

  def start_consuming_messages(queue_name = 'tasks')
    AMQP.start(:host => 'localhost' ) do
      @q = MQ.new.queue(queue_name, {:durable => true})
      @q.subscribe(:ack => true) do |header, msg|
        begin
          marshalled_message = Marshal.load(msg)
          if self.handle(marshalled_message)
            header.ack
          end
        rescue
          puts "Oh shit: #{msg}"
        end
     end
    end
  end
  
  def publish(message, queue_name="tasks")
    #puts "Publishing #{message} on #{queue_name}"
    queue = MQ.new.queue(queue_name, {:durable => true})
    queue.publish(Marshal.dump(message))
  end
end
