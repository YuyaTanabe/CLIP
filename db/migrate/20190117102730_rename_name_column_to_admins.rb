class RenameNameColumnToAdmins < ActiveRecord::Migration[5.2]
  def change
    rename_column :admins, :name, :admin_name
  end
end
