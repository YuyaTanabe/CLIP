class Message < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :room, optional: true

  # バリデーション
  validates :content, length: { maximum: 1000 }

  # paranoia
  acts_as_paranoid
end
