class EarthquakesController < ApplicationController
    def index
        @earthquakes = Earthquake.all
        render json: @earthquakes, status: :ok
    end

    def show
        @earthquake = Earthquake.find(params[:id])
        render json: @earthquake, status: :ok
    end
end