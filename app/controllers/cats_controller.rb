class CatsController < ApplicationController

  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def create
    @cat = Cat.new(cat_params)
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
    fail
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def destroy

  end

  private
  def cat_params
    params.require(:cat)
          .permit(:age, :birthdate, :color, :description, :sex, :name)
  end

end
