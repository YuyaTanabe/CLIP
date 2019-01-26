class AddIndexEntriesDeletedAt < ActiveRecord::Migration[5.2]
  def change
    add_index :entries, :deleted_at
  end
end
