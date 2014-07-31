class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(
    params[:user][:username],
    params[:user][:password]
    )
    if @user.nil?
      render :new
    else
      redirect_to user_url(@user)
    end
  end

  def destroy
  end
end
