class CatRentalRequestsController < ApplicationController


  def new
    @cats = Cat.all
    @request = CatRentalRequest.new

    render :new
  end

  def create
    @request = CatRentalRequest.new(cat_rental_request_params)

    if @request.save
      redirect_to cats_url
    else
      render :new
    end

  end

  private

  def cat_rental_request_params
    params.require(:cat_rental_request)
      .permit(:cat_id, :start_date, :end_date)
  end
end
