class CatsController < ApplicationController

  before_action :validate_cat_ownership, only: [:edit, :update]

  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.includes(:rental_requests, :owner).find(params[:id])
    render :show
  end

  def create
    @cat = Cat.new(cat_params)
    @user_id = @cat.user_id
    if @cat.save
      redirect_to cat_url(@cat)
    else
      redirect_to new_cat_url
    end
  end

  def new
    @cat = Cat.new
    render :new
  end

  def update
    @cat = Cat.find(params[:id])
    @user = User.find(@cat.user_id)
    if @cat.update(cat_params)
      redirect_to cat_url(@cat)
    else
      redirect_to edit_cat_url
    end
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def destroy
    @cat = Cat.find(params[:id])
    @cat.destroy
    redirect_to cats_url
  end

  private
  def cat_params
    params.require(:cat)
          .permit(:age, :birthdate, :color, :description, :sex, :name)
  end

end
