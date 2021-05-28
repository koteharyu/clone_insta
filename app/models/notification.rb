class Notification < ApplicationRecord
  belongs_to :noticeable
  belongs_to :user
end
