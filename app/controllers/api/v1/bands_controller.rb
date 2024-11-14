module Api
  module V1
    class BandsController < ApplicationController
      def index
        city = params[:city] || BandSearchService.get_user_location
        bands = BandSearchService.get_bands_by_location(city)

        render json: bands
      end
    end
  end
end
