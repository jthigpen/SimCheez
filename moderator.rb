require 'rubygems'
load './simcheez.rb'

class ModeratorMessageHandler < MessageHandler
  def asset_created(msg)
    puts "Asset Created Pending Moderation: #{msg.asset_id}"
    if Random.rand > 0.5
      publish(AssetApprovedMessage.new(msg.asset_id))
    else
      publish(AssetDeniedMessage.new(msg.asset_id))
    end
  end
end

ModeratorMessageHandler.new.start_consuming_messages
