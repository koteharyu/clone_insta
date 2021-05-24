class ApplicationController < ActionController::Base

  add_flash_types :waring, :success, :info, :danger

  before_action :require_login

  protected

  def not_authenticated
    redirect_to login_url
  end
end
