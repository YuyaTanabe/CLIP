class Friendship < ApplicationRecord
  # 外部キーが複数ある場合のアソシエーション
  # friendshipテーブルのfrom_user_idカラムまたはto_user_idカラムの値と同じidの値を持つユーザーが削除されると、friendshipテーブルのレコードも削除される
  belongs_to :from_user, class_name: 'User', :foreign_key => 'from_user_id'
  belongs_to :to_user, class_name: 'User', :foreign_key => 'to_user_id'

  # paranoia
  acts_as_paranoid
end
