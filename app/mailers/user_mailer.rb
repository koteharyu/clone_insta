class UserMailer < ApplicationMailer
  def comment_post
    @user_from = params[:user_from]
    @user_to = params[:user_to]
    @comment = params[:comment]
    mail(to: @user_to.email, subject: "#{@user_from.name}があなたの投稿にコメントしました")
  end

  def like_post
    @user_from = params[:user_from]
    @user_to = params[:user_to]
    @comment = params[:comment]
    mail(to: @user_to.email, subject: "#{@user_from.name}があなたの投稿にいいねしました"
  end

  def follow
    @user_from = parmas[:user_from]
    @user_to = params[:user_to]
    mail(to: @user_to.email, subject: "#{@user_from.name}があなたをフォローしました")
  end
end
