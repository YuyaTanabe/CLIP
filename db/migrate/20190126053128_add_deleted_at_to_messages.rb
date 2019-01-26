class AddDeletedAtToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :deleted_at, :datetime
  end
end
