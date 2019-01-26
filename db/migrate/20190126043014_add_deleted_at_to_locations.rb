class AddDeletedAtToLocations < ActiveRecord::Migration[5.2]
  def change
    add_column :locations, :deleted_at, :datetime
  end
end
