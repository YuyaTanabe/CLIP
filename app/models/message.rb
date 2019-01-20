class Message < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :room, optional: true
end
