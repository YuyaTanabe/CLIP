class Entry < ApplicationRecord
  belongs_to :room, optional: true
  belongs_to :user, optional: true
end
