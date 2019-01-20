class Room < ApplicationRecord
  # 外部キーが複数ある場合のアソシエーション
  # roomテーブルのinvite_user_idカラムまたはinvited_user_idカラムの値と同じidの値を持つユーザーが削除されると、roomテーブルのレコードも削除される
  belongs_to :invite_user, class_name: 'User', :foreign_key => 'invite_user_id'
  belongs_to :invited_user, class_name: 'User', :foreign_key => 'invited_user_id'

  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
end
