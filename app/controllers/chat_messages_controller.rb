class ChatMessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_chat, only: [:index]
  after_action :publish_message, only: [:create]

  def index
    if @chat
      @messages = Message.where(chat_id: @chat.chat_id)
      @chat_id = @chat.chat_id
    else
      @chat_id = "#{current_user.id}:#{params[:user_profile_id]}"
      companion = 
      current_user.chats.create({companion_id: params[:user_profile_id], chat_id: @chat_id})
      User.find(params[:user_profile_id]).chats.create({companion_id: current_user.id, chat_id: @chat_id})
      @messages = []
    end
    gon.chat_id = @chat_id
    @messages
  end

  def create
    @message = current_user.messages.create(message_params)
  end

  private

  def message_params
    params.require(:message).permit(:body, :chat_id)
  end

  def find_chat
    @chat = current_user.chats.where(companion_id: params[:user_profile_id]).first
  end

  def publish_message
    return if @message.errors.any?
    ActionCable.server.broadcast(
      "chat_#{@message.chat_id}",
      message: @message,
      author: current_user.id
    )
  end
end
