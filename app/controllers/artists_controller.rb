# frozen_string_literal: true

class ArtistsController < ApplicationController
  before_action :set_preferences, only: %i[index new]
  before_action :set_artist, only: %i[show edit update destroy]

  def index
    @artists = Artist.all
  end

  def show; end

  def new
    if @preferences.allow_create_artists
      @artist = Artist.new
    else
      redirect_to artists_path
    end
  end

  def create
    @artist = Artist.new(artist_params)

    if @artist.save
      redirect_to @artist
    else
      render :new
    end
  end

  def edit; end

  def update
    @artist.update(artist_params)

    if @artist.save
      redirect_to @artist
    else
      render :edit
    end
  end

  def destroy
    @artist = Artist.find(params[:id])
    @artist.destroy
    flash[:notice] = "Artist deleted."
    redirect_to artists_path
  end

private

  def set_artist
    @artist = Artist.find(params[:id])
  end

  def set_preferences
    @preferences = Preference.first
  end

  def artist_params
    params.require(:artist).permit(:name)
  end
end
