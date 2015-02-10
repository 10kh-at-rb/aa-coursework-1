class CatsController < ApplicationController

  def index
    @cats = Cat.all

    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    @sorted_requests = @cat.rental_requests.order(:start_date)
    # @sorted_requests = requests.sort_by {|request| request[:start_date]}
    render :show
  end

  def new
    @cat = Cat.new

    render :new
  end

  def edit
    @cat = Cat.find(params[:id])

    render :edit
  end

  def update
    @cat = Cat.find(params[:id])

    if @cat.update(cat_params)
      redirect_to cat_url(@cat)
    else
      render :edit
    end
  end

  def create
    @cat = Cat.new(cat_params)
    if @cat.save
      redirect_to cat_url(@cat)
    else
      render :new
    end
  end




  private
  def cat_params
    params.require(:cat)
      .permit(:birth_date, :name, :color, :sex, :description)
  end

end
