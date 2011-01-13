require 'rubygems'
load './simcheez.rb'

class MineMessageHandler
  def asset_upload(msg)
    puts "Asset Uploaded: #{msg.asset_id}"
  end
end

consume_messages do |msg| 
  puts "Received #{msg.type}"
  MineMessageHandler.new.send(msg.type, msg)
end
