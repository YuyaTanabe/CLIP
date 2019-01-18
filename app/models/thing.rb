class Thing < ApplicationRecord
  belongs_to :user, optional: true

  attachment :thing_image

  # ラジオボタン
  enum public_status: {公開しない:1, 公開する:2}

end
