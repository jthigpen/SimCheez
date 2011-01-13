require 'rubygems'
load './simcheez.rb'

class MineMessageHandler < MessageHandler
  def asset_uploaded(msg)
    puts "Asset Uploaded: #{msg.asset_id}"
    publish AssetCreatedMessage.new(msg.asset_id)
  end

  def asset_approved(msg)
    puts "Asset #{msg.asset_id} Approved for Voting!"
  end

  def asset_denied(msg)
    puts "Asset #{msg.asset_id} Denied! REJECTED!!"
  end
end

MineMessageHandler.new.start_consuming_messages
