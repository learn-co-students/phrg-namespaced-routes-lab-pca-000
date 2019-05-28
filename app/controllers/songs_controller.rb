# frozen_string_literal: true

class SongsController < ApplicationController
  before_action :set_preferences, only: %i[index new]

  def index
    if params[:artist_id]
      @artist = Artist.find_by(id: params[:artist_id])
      check
    elsif @preferences&.song_sort_order
      @songs = Song.order(title: @preferences.song_sort_order)
    else
      @songs = Song.all
    end
  end

  def show # rubocop:disable Metrics/AbcSize
    if params[:artist_id]
      @artist = Artist.find_by(id: params[:artist_id])
      @song = @artist.songs.find_by(id: params[:id])
      if @song.nil?
        redirect_to artist_songs_path(@artist), alert: "Song not found"
      end
    else
      @song = Song.find(params[:id])
    end
  end

  def new
    if @preferences && !@preferences.allow_create_songs
      redirect_to songs_path
    else
      @song = Song.new
    end
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

  def set_preferences
    @preferences = Preference.first
  end

  def check
    if @artist.nil?
      redirect_to artists_path, alert: "Artist not found"
    elsif @preferences&.song_sort_order
      @songs = @artist.songs.order(title: @preferences.song_sort_order)
    else
      @songs = @artist.songs
    end
  end
end
