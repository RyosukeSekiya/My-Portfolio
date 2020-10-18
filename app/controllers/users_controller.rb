class UsersController < ApplicationController
  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end

  def show
    @user = User.find(params[:id])
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

    private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
  end

  def edit
    # @user = User.find(params[:id])
  end

  def update
  end

  def destroy
  end
end
