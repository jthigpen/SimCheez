require 'rubygems'
load './simcheez.rb'

consume_messages do |msg| 
  puts msg.type, msg.asset_id
end
