require 'rubygems'
load './simcheez.rb'

class MineMessageHandler < MessageHandler
  def asset_uploaded(msg)
    puts "Saving Asset To Database: #{msg.asset_id}"
    publish(AssetCreatedMessage.new(msg.asset_id), "moderation")
  end

  def asset_approved(msg)
    update_asset(msg.asset_id, "Approved")
    publish(PublishToVotingMessage.new(msg.asset_id), 'publication')
  end

  def asset_denied(msg)
    update_asset(msg.asset_id, "Denied")
  end

  def asset_featured(msg)
    update_asset(msg.asset_id, "Featured")
    publish(PublishToFrontPageMessage.new(msg.asset_id), 'publication')
  end

  def update_asset(asset_id, state)
    puts "Updating Asset #{asset_id} to #{state}"
  end
end

MineMessageHandler.new.start_consuming_messages
