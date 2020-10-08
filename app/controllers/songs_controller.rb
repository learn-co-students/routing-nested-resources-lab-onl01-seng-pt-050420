class SongsController < ApplicationController
  def index
    @artist = Artist.where(id: params[:artist_id])
    if params[:artist_id].blank?
      @songs = Song.all
    elsif !@artist.empty?
      @songs = @artist.first.songs
    else
      flash[:notice] = "Artist not found."
      redirect_to artists_path
    end
  end
  
  def show
    @song = Song.where(id: params[:id])
    if !@song.empty?
      @song = @song.first
    else
      flash[:alert] = "User not found."
      flash[:alert] = "Song not found."
      redirect_to artist_songs_path(params[:artist_id])
    end 
  end
  
  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name)
  end
end

