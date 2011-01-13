require 'rubygems'
load './simcheez.rb'

class WordPressMessageHandler < MessageHandler
  def publish_to_voting(msg)
    puts "Pushing Asset #{msg.asset_id} to the vote page!"
    sleep 5 
    publish(AssetPostedToVotePageMessage.new(msg.asset_id), 'moderation')
  end

  def publish_to_front_page(msg)
    puts "Pushing Asset #{msg.asset_id} to the Front Page! OMFGz!"
    sleep 5
    publish AssetFeaturedOnHomepageMessage.new(msg.asset_id)
  end
end

WordPressMessageHandler.new.start_consuming_messages('publication')
