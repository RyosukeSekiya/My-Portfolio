class UsersController < ApplicationController
  before_action :require_user_logged_in, only: %i[index show edit update destroy followings followers]
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(id: :desc).page(params[:page]).per(5)
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザの作成に成功しました'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの作成に失敗しました'
      render :new
    end
  end

  def edit
    # @user = User.find(params[:id])
  end

  def update
  end

  def destroy
  end

  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end

  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
