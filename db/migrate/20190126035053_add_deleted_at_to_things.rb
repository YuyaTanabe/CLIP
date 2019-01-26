class AddDeletedAtToThings < ActiveRecord::Migration[5.2]
  def change
    add_column :things, :deleted_at, :datetime
  end
end
