class AddIndexThingsDeletedAt < ActiveRecord::Migration[5.2]
  def change
    add_index :things, :deleted_at
  end
end
