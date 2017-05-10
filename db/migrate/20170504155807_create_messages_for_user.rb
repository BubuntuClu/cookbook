class CreateMessagesForUser < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.string :body
      t.belongs_to :user, index: true
      t.string :chat_id

      t.timestamps
    end
  end
end
