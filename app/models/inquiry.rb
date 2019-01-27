class Inquiry
  include ActiveModel::Model

  attr_accessor :name, :email, :content

  validates :name, presence: true, length: { maximum: 20 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 30 },
                    format: { with: VALID_EMAIL_REGEX }
  validates :content, presence: true, length: { maximum: 2000 }
end

