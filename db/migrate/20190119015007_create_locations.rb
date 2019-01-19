class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.string :location_name
      t.string :location_image_id
      t.string :station
      t.string :location_url
      t.text :location_memo
      t.string :address
      t.float :latitude
      t.float :longitude
      t.integer :public_status
      t.integer :user_id

      t.timestamps
    end
  end
end
