class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.integer :from_user_id
      t.integer :to_user_id
      t.string :to_friend_id

      t.timestamps
    end
  end
end
