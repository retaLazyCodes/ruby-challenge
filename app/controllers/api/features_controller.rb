module Api
  class FeaturesController < ApplicationController
    before_action :validate_per_page, only: [:index]
    before_action :validate_mag_type, only: :index

    def index
      @features = Feature.all
      @features = @features.where(mag_type: params[:mag_type].split(',')) if params[:mag_type].present?
      @features = @features.page(params[:page]).per(params[:per_page])
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

    def validate_mag_type
      if params[:mag_type].present?
        mag_types = params[:mag_type].split(',')
        valid_mag_types = %w(md ml ms mw me mi mb mlg)
        invalid_mag_types = mag_types - valid_mag_types
        if invalid_mag_types.present?
          error_msg = "Invalid mag_type values: #{invalid_mag_types.join(', ')}"
          render json: { error: error_msg }, status: :unprocessable_entity
          return
        end
      end
    end
  end
end
