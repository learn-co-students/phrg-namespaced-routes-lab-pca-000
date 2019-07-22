# frozen_string_literal: true

module Admin
  class PreferencesController < ApplicationController
    def index
      @preferences = Preference.all
    end

    def new
      @preference = Preference.new
    end

    def create
      @preference = Preference.new(pref_params)
      if @preference.save
        redirect_to @preference
      else
        render "new"
      end
    end

    def show
      @preference = Preference.find(params[:id])
    end

    def edit
      @preference = Preference.find(params[:id])
    end

    def update
      @preference = Preference.find(params[:id])
      @preference.update(pref_params)
      if @preference.save
        redirect_to @preference
      else
        render "edit"
      end
    end

  private

    def pref_params
      params.require(:admin_preference).permit(
        :artist_sort_order,
        :song_sort_order,
        :allow_create_songs,
        :allow_create_artists
      )
    end
  end
end
