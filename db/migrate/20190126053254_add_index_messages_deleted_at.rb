class AddIndexMessagesDeletedAt < ActiveRecord::Migration[5.2]
  def change
    add_index :messages, :deleted_at
  end
end
