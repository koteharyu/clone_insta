module Noticeable
  extend ActiveSupport::Concern
  include Rails.application.routes.url_helpers
  included do
    has_one :notification, as: :noticeable
    after_create_commit :create_notification
  end

  def partial_name
    raise NotImplementedError
  end

  def resource_path
    raise NotImplementedError
  end

  def notification_user
    raise NotImplementedError
  end

  private
  def create_notification
    Notification.create(noticeable: self, user: notification_user)
  end
end
