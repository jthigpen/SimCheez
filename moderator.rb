require 'rubygems'
load './simcheez.rb'

class ModeratorMessageHandler < MessageHandler
  def asset_created(msg)
    if Random.rand > 0.5
      puts "Moderating Asset Approved: #{msg.asset_id}"
      publish(AssetApprovedMessage.new(msg.asset_id))
    else
      puts "Moderating Asset Denied:   #{msg.asset_id}"
      publish(AssetDeniedMessage.new(msg.asset_id))
    end
  end

  def asset_posted_to_vote_page(msg)
    puts "Evaluating Asset #{msg.asset_id} for featuring."
    if Random.rand > 0.5
      puts "Featuring Asset #{msg.asset_id}"
      publish(AssetFeaturedMessage.new(msg.asset_id))
    else
      puts "Ignoring Asset #{msg.asset_id}. Not Funny."
    end
  end
end

ModeratorMessageHandler.new.start_consuming_messages('moderation')
