class ToysController < ApplicationController
  def show
    @toy = Toy.find(params[:id])
    render :show
  end

  def update
    @toy = Toy.find(params[:id])

    if @toy.update(toy_params)
      render 'show'
    else
      render json: @toy.errors.full_messages, status: 422
    end
  end

  def toy_params
    params.require(:toy).permit(:pokemon_id)
  end
end
