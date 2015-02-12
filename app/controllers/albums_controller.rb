class AlbumsController < ApplicationController
  def create
    @album = Album.new(album_params)

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
    @album.update(album_params)

    redirect_to album_url(@album)
  end

  def destroy
    Album.find(params[:id]).destroy
  end

  private
  def album_params
    params.require(:album).permit(:name, :band_id, :album_type)
  end
end
