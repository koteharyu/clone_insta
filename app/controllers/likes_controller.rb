class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    current_user.like(@post)
    if @post.user.notification_on_like
      UserMailer.with(user_from: current_user, user_to: @post.user, post: @post).like_post.deliver_later
    end
  end

  def destroy
    @post = Like.find(params[:id]).post
    current_user.unlike(@post)
  end
end
