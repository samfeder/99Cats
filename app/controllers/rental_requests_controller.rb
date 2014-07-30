class RentalRequestsController < ApplicationController

  def index
    @rentals = CatRentalRequest.all.includes(:cat)
    render :index
  end

  def show

  end

  def create
    @rental = CatRentalRequest.create(request_params)
    if @rental.save
      redirect_to rental_request_url(@rental)
    else
      redirect_to new_rental_request_url
    end
  end

  def new
    @rental = CatRentalRequest.new
    render :new
  end

  def update

  end

  def edit

  end

  def destroy

  end

  private

  def request_params
    params.require(:cat_rental_request)
           .permit(:cat_id, :start_date, :end_date, :status)
  end

end
