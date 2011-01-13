require 'rubygems'
load './simcheez.rb'

class MineMessageHandler < MessageHandler
  def asset_upload(msg)
    puts "Asset Uploaded: #{msg.asset_id}"
    publish AssetCreatedMessage.new(msg.asset_id)
  end
end

MineMessageHandler.new.start_consuming_messages
