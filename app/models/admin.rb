class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

# バリデーション
  validates :admin_name, presence: true
  validates :admin_name, length: { minimum: 2 }
  validates :admin_name, length: { maximum: 10 }
end
