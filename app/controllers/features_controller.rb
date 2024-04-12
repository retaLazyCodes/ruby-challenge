class FeaturesController < ApplicationController
    def index
        @features = Feature.all
        render json: @features, status: :ok
    end

    def show
        @feature = Feature.find(params[:id])
        render json: @feature, status: :ok
    end
end