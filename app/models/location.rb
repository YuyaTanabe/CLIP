class Location < ApplicationRecord
  belongs_to :user, optional: true

  attachment :location_image

  # ラジオボタン
  enum public_status: {公開しない:1, 公開する:2}

  # geocoder が address から経度・緯度を取得
  geocoded_by :address
  after_validation :geocode

# バリデーション
  validates :location_name, presence: true

end
