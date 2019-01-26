class AddIndexRoomsDeletedAt < ActiveRecord::Migration[5.2]
  def change
    add_index :rooms, :deleted_at
  end
end
