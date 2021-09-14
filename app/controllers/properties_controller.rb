# frozen_string_literal: true

# List properties through the index action
class PropertiesController < ApplicationController
  # GET /properties
  def index
    request = Properties::ListProperties.call(search_params)

    if request.success?
      render json: PropertySerializer.new(request.properties).serializable_hash.to_json
    else
      render json: { errors: request.error }, status: request.status
    end
  end

  private

  def search_params
    params.permit(:lng, :lat, :marketing_type, :property_type)
  end
end
