class AddDeletedAtToEntries < ActiveRecord::Migration[5.2]
  def change
    add_column :entries, :deleted_at, :datetime
  end
end
