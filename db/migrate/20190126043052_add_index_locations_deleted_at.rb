class AddIndexLocationsDeletedAt < ActiveRecord::Migration[5.2]
  def change
    add_index :locations, :deleted_at
  end
end
