class TracksController < ApplicationController
  before_action :redirect_if_not_logged_in, except: [:index, :show]
  
  def create
    @track = Track.new(track_params)
    @track.album_id = params[:album_id]

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

    if @track.update(track_params)
      redirect_to track_url(@track)
    else
      render :edit
    end
  end

  def destroy
    @track = Track.find(params[:id])
    @track.destroy

    redirect_to album_url(@track.album_id)
  end

  private
  def track_params
    params.require(:track).permit(:name, :album_id, :track_type, :lyrics)
  end
end
