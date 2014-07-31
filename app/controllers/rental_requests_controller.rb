class RentalRequestsController < ApplicationController
  before_action :validate_rental_ownership, only: [:new, :create, :approve, :deny]
  def index
    @rentals = CatRentalRequest.all.includes(:cat)
    render :index
  end

  def show
    redirect_to rental_requests_url
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

  def approve
    @rental = CatRentalRequest.find(params[:id])
    @rental.approve!
    redirect_to rental_requests_url
  end

  def deny
    @rental = CatRentalRequest.find(params[:id])
    @rental.deny!
    redirect_to rental_requests_url
  end

  private

  def request_params
    params.require(:cat_rental_request)
           .permit(:cat_id, :start_date, :end_date, :status)
  end

end
