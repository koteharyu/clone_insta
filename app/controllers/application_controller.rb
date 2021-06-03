class ApplicationController < ActionController::Base
  add_flash_types :waring, :success, :info, :danger

  before_action :require_login
  before_action :set_search_form

  def set_search_form
    @search_form = SearchPostsForm.new(search_params)
  end

  def search_params
    params.fetch(:search, {}).permit(:post_body, :comment_body, :user_name)
  end

  protected

  def not_authenticated
    redirect_to login_url
  end
end
