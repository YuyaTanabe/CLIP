class AddDeletedAtToFriendships < ActiveRecord::Migration[5.2]
  def change
    add_column :friendships, :deleted_at, :datetime
  end
end
