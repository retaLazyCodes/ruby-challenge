module Api
    class FeaturesController < ApplicationController
      def index
        @features = Feature.page(params[:page]).per(params[:per_page])
        @current_page = @features.current_page
        @total = @features.total_count
        @per_page = @features.limit_value
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