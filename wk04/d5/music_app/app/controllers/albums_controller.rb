class AlbumsController < ApplicationController
  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to album_url(@album.id)
    else
      flash.now[:errors] = @album.errors.full_messages
      render 'new'
    end
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    redirect_to band_url(@album.band_id)
  end

  def edit
    @album = Album.find(params[:id])
    render 'edit'
  end

  def index
    @albums = Album.all
    render 'index'
  end

  def new
    @album = Album.new
    render 'new'
  end

  def show
    @album = Album.find(params[:id])
    render 'show'
  end

  def update
    @album = Album.find(params[:id])
    if @album.update_attributes(album_params)
      redirect_to album_url(@album.id)
    else
      flash.now[:errors] = @album.errors.full_messages
      render 'edit'
    end
  end

  private 
  def album_params
    params.require(:album).permit(:name, :recording_type, :band_id)
  end
end