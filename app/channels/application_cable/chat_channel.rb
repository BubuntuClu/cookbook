class ChatChannel < ApplicationCable::Channel
  def subscribed

  end
  
  def follow_chat_messages(chat_id)
    stream_from "chat_#{@chat_id}"
  end
end
