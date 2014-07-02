class TracksController < ApplicationController
  def create
    @track = Track.new(track_params)
    if @track.save
      redirect_to track_url(@track.id)
    else
      flash.now[:errors] = @track.errors.full_messages
      render 'new'
    end
  end

  def destroy
    @track = Track.find(params[:id])
    @track.destroy
    redirect_to album_tracks_url(@track.album_id)
  end

  def destroy_note
    @note = Note.find(params[:note_id])
    @note.destroy
    redirect_to track_url(params[:id])
  end

  def edit
    @track= Track.find(params[:id])
    render 'edit'
  end

  def index
    @tracks = Track.all
    render 'index'
  end

  def new
    @track = Track.new
    render 'new'
  end

  def new_note
    if !logged_in?
      flash.now[:errors] = ["You must be logged in to create a note."]
      render 'show'
    end
    @note = Note.new(note_params)
    note.track_id = params[:id]
    note.user_id = current_user.id
    if @note.save
        redirect_to track_url(params[:id])
    else
      flash.now[:errors] = @note.errors.full_messages
      render 'show'
    end
  end

  def show
    @track = Track.find(params[:id])
    render 'show'
  end

  def update
    @track = Track.find(params[:id])
    if @track.update_attributes(track_params)
      redirect_to track_url(@track.id)
    else
      flash.now[:errors] = @track.errors.full_messages
      render 'edit'
    end
  end

  private 
  def track_params
    params.require(:track).permit(:name, :album_id, :track_type, :lyrics)
  end

  def note_params
    params.require(:note).permit(:text)
  end
end