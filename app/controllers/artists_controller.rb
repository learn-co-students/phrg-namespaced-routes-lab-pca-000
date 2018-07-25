# frozen_string_literal: true

class ArtistsController < ApplicationController
  before_action :set_artist, only: %i[show edit update destroy]
  def index
    @artists = Artist.all
  end

  def show; end

  def new
    # binding.pry
    if !preferences
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
    @artist.destroy
    flash[:notice] = "Artist deleted."
    redirect_to artists_path
  end

private

  def set_artist
    @artist = Artist&.find_by(id: params[:id])
  end

  def artist_params
    params.require(:artist).permit(:name)
  end

  def preferences
    @preferences = Preference.first
  end
end
