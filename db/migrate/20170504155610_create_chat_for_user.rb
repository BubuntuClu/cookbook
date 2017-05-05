class CreateChatForUser < ActiveRecord::Migration[5.0]
  def change
    create_table :chats do |t|
      t.belongs_to :user, index: true
      t.integer :companion_id
      t.string :chat_id

      t.timestamps
    end
  end
end
