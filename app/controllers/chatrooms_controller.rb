class ChatroomsController < ApplicationController
  before_action :require_login, only: %i[index show create]
  before_action :require_user_ids, only: %i[create]

  def index
    @chatrooms = current_user.chatrooms.includes(:users, messages: :user).page(params[:page]).order(created_at: :desc)
  end

  def create
    users = User.where(id: params.dig(:chatroom, :user_ids)) + [current_user]
    @chatroom = Chatroom.chatroom_for_users(users)
    redirect_to chatroom_path(@chatroom)
  end

  def show
    @chatroom = current_user.chatrooms.includes(:users).find(params[:id])
    @messages = @chatroom.messages.recent(100)
  end

  private

  def require_user_ids
    redirect_back(fallback_location: root_path, danger: 'パラメータが不正です') if params.dig(:chatroom, :user_ids).reject(&:blank?).blank?
  end
end
