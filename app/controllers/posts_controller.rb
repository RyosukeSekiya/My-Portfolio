class PostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user,only: %i[destroy]

  def create
    @post = current_user.posts.build(posts_params)
    if @post.save
      flash[:success] = '投稿しました'
      redirect_to root_url
    else
      @posts = current_user.posts.order(id: :desc).page(params[:page])
      flash.now[:danger]='投稿できませんでした'
      render 'homes/index'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = '削除しました'
    redirect_back(fallback_location: root_path)
  end

  private

  def posts_params
    params.require(:post).permit(:content)
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to root_url
    end
  end
  
end
