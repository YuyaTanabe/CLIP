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

  # 外部キーが複数ある場合のアソシエーション
  # roomテーブルのinvite_user_idカラムまたはinvited_user_idカラムの値と同じidの値を持つユーザーを削除すると、roomテーブルのレコードも削除される
  has_many :invite_user_transactions, class_name: 'Room', :foreign_key => 'invite_user_id', dependent: :destroy
  has_many :invited_user_transactions, class_name: 'Room', :foreign_key => 'invited_user_id', dependent: :destroy

  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy

  # バリデーション
  validates :user_name, presence: true
  validates :user_name, length: { minimum: 2 }
  validates :user_name, length: { maximum: 20 }
  validates :friend_id, presence: true, uniqueness: true
  validates :friend_id, length: { minimum: 4 }
  validates :friend_id, length: { maximum: 20 }

  # paranoia
  acts_as_paranoid


  # user(=入力したフレンドIDを持つユーザー)とすでにフレンド関係にあるかの確認
  def is_friend?(user)
    Friendship.where(from_user_id: self.id, to_user_id: user.id).exists?
  end

  # user(=ユーザーページのユーザー)との間でチャットルームが存在するかの確認
  def have_a_room?(user)
    first_friendship = Friendship.find_by(from_user_id: self.id, to_user_id: user.id)
    Room.where(friendship_id: first_friendship.id).exists?
    second_friendship = Friendship.find_by(from_user_id: user.id, to_user_id: self.id)
    Room.where(friendship_id: second_friendship.id).exists?
  end

  # user(=ユーザーページのユーザー)のIDとFriendshipのto_user_idが一致する場合に、そのFriendshipのIDを持つチャットルームが存在するかの確認
  def have_one_friendshipID_of_the_room?(user)
    one_friendship = Friendship.find_by(from_user_id: self.id, to_user_id: user.id)
    Room.where(friendship_id: one_friendship.id).exists?
  end

  # user(=ユーザーページのユーザー)のIDとFriendshipのfrom_user_idが一致する場合に、そのFriendshipのIDを持つチャットルームが存在するかの確認
  def have_another_friendshipID_of_the_room?(user)
    another_friendship = Friendship.find_by(from_user_id: user.id, to_user_id: self.id)
    Room.where(friendship_id: another_friendship.id).exists?
  end

end
