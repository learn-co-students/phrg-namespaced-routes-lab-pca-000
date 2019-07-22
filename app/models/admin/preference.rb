# frozen_string_literal: true

module Admin
  class Preference < ActiveRecord::Base
    def self.new_songs?
      allow_create_songs ? "ON" : "OFF"
    end

    def self.new_artists?
      allow_create_artists ? "ON" : "OFF"
    end
  end
end
