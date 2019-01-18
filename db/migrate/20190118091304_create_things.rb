class CreateThings < ActiveRecord::Migration[5.2]
  def change
    create_table :things do |t|
      t.string :thing_name
      t.string :thing_image_id
      t.string :thing_url
      t.text :thing_memo
      t.integer :public_status
      t.integer :user_id

      t.timestamps
    end
  end
end
