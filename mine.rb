require 'rubygems'
load './simcheez.rb'

class MessageHandler 
  def handle(msg)
    self.send(msg.type, msg)
  end
end

class MineMessageHandler < MessageHandler
  def asset_upload(msg)
    puts "Asset Uploaded: #{msg.asset_id}"
  end
end

start_consuming_messages(MineMessageHandler.new)
