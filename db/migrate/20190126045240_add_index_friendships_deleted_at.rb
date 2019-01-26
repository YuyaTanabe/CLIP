class AddIndexFriendshipsDeletedAt < ActiveRecord::Migration[5.2]
  def change
    add_index :friendships, :deleted_at
  end
end
