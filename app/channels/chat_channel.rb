class ChatChannel < ApplicationCable::Channel
  def follow_chat_messages(data)
    stream_from "chat_#{data['chat_id']}"
  end
end
