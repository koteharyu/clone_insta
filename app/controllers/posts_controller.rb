class PostsController < ApplicationController
  skip_before_action :require_login, only: [:index, :show]

  def index
    @posts = Post.all.includes(:user).order(created_at: :desc).page(params[:page])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, notice: "投稿に成功しました"
    else
      flash.now[:danger] = "投稿に失敗しました"
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      redirect_to posts_path, success: "投稿の更新に成功しました"
    else
      flash.now[:danger] = "投稿の更新に失敗しました"
      render :edit
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy!
    redirect_to posts_path, success: "投稿を削除しました"
  end

  private
  def post_params
    params.require(:post).permit(:body, images: [])
  end
end
