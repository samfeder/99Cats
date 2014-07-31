class UsersController < ApplicationController
  before_action :require_current_user!, except: [:create, :new]

  def create
    @user = User.new(user_params)

    if @user.save
      login!(@user)
    else
      render :new
    end
  end



  def new
    @user = User.new
  end

  def show
    @user = current_user
    if Integer(params[:id]) != @user.id
      redirect_to user_url(@user)
      flash[:notice] = "Can only view your profile"
    else
      render :show
    end
  end


  private

  def user_params
    params.require(:user).permit(:username, :password)
  end



end