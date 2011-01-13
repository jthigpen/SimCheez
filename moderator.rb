require 'rubygems'
load './simcheez.rb'

class ModeratorMessageHandler < MessageHandler
  def asset_created(msg)
    puts "Asset Created Pending Moderation: #{msg.asset_id}"
  end
end

ModeratorMessageHandler.new.start_consuming_messages
