class AlbumsController < ApplicationController
  before_action :redirect_if_not_logged_in, except: [:index, :show]
  before_action :redirect_if_not_admin, except: [:show]

  def create
    @album = Album.new(album_params)
    @album.band_id = params[:band_id]

    if @album.save
      redirect_to album_url(@album)
    else
      render :new
    end
  end

  def new
    @album = Album.new

    render :new
  end

  def edit
    @album = Album.find(params[:id])

    render :edit
  end

  def show
    @album = Album.find(params[:id])

    render :show
  end

  def update
    @album = Album.find(params[:id])

    if @album.update(album_params)
      redirect_to album_url(@album)
    else
      render :edit
    end
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy

    redirect_to band_url(@album.band_id)
  end

  private
  def album_params
    params.require(:album).permit(:name, :band_id, :album_type)
  end
end
