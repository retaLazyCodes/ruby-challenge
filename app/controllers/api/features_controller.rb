module Api
  class FeaturesController < ApplicationController
    before_action :validate_per_page, only: [:index]

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

    private

    def validate_per_page
      per_page = params[:per_page].to_i
      if per_page > 1000
        render json: { error: 'Per_page must be less than or equal to 1000' }, status: :unprocessable_entity
      end
    end
  end
end
