# == Schema Information
#
# Table name: notifications
#
#  id            :integer          not null, primary key
#  read          :boolean          default(FALSE), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  noticeable_id :integer
#  user_id       :integer
#
# Indexes
#
#  index_notifications_on_noticeable_id  (noticeable_id)
#  index_notifications_on_user_id        (user_id)
#
class Notification < ApplicationRecord
  belongs_to :noticeable, polymorhpic: true
  belongs_to :user
end
