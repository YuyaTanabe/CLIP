class AddIndexUsersDeletedAt < ActiveRecord::Migration[5.2]
  def change
    add_index :users, :deleted_at
  end
end
