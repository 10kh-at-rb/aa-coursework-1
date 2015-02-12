class TracksController < ApplicationController
  def create
    @track = Track.new(track_params)

    if @track.save
      redirect_to track_url(@track)
    else
      render :new
    end
  end

  def new
    @track = Track.new

    render :new
  end

  def edit
    @track = Track.find(params[:id])

    render :edit
  end

  def show
    @track = Track.find(params[:id])

    render :show
  end

  def update
    @track = Track.find(params[:id])
    @track.update(track_params)

    redirect_to track_url(@track)
  end

  def destroy
    Track.find(params[:id]).destroy
  end

  private
  def track_params
    params.require(:track).permit(:name, :album_id, :track_type, :lyrics)
  end
end
