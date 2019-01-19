class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :user_image

  has_many :things, dependent: :destroy

  has_many :locations, dependent: :destroy

  # 外部キーが複数ある場合のアソシエーション
  # friendshipテーブルのfrom_user_idカラムまたはto_user_idカラムの値と同じidの値を持つユーザーを削除すると、friendshipテーブルのレコードも削除される
  has_many :from_user_transactions, class_name: 'Friendship', :foreign_key => 'from_user_id', dependent: :destroy
  has_many :to_user_transactions, class_name: 'Friendship', :foreign_key => 'to_user_id', dependent: :destroy

  # user(=入力したフレンドIDを持つユーザー)とすでにフレンド関係にあるかの確認
  def is_friend?(user)
    Friendship.where(from_user_id: self.id, to_user_id: user.id).exists?
  end

end
