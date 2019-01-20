class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.integer :friendship_id
      t.integer :invite_user_id
      t.integer :invited_user_id

      t.timestamps
    end
  end
end
