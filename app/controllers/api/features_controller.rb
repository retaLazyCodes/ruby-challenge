module Api
    class FeaturesController < ApplicationController
        def index
            @features = Feature.all
        end

        def show
            @feature = Feature.find_by(id: params[:id])
            if @feature
              render json: @feature.as_json(include_comments: true), status: :ok
            else
              render json: { error: 'Feature not found' }, status: :not_found
            end
        end
    end
end