# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/properties', type: :request do
  def json
    JSON.parse(response.body, symbolize_names: true)
  end

  let(:params) { attributes_for(:property).slice(:lat, :lng, :property_type).merge(marketing_type: 'sell') }

  describe 'GET /index' do
    context 'with valid parameters' do
      it 'renders a successful response' do
        create_list(:property, 2)
        get properties_url, params: params
        expect(response).to be_successful
        expect(response.content_type).to match(a_string_including('application/json'))
        expect(json[:data].count).to eq(2)
      end
    end

    context 'with missing longitude parameter' do
      it 'responds with error message' do
        create_list(:property, 2)
        get properties_url, params: params.except(:lng)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
        expect(json[:errors][:lng]).to include(I18n.t('errors.messages.blank'))
      end
    end

    context 'with invalid longitude parameter' do
      it 'responds with error message' do
        create_list(:property, 2)
        get properties_url, params: params.tap { params[:lng] = 'abc' }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
        expect(json[:errors][:lng]).to include(I18n.t('errors.messages.not_a_number'))
      end
    end

    context 'with missing latitude parameter' do
      it 'responds with error message' do
        create_list(:property, 2)
        get properties_url, params: params.except(:lat)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
        expect(json[:errors][:lat]).to include(I18n.t('errors.messages.blank'))
      end
    end

    context 'with invalid latitude parameter' do
      it 'responds with error message' do
        create_list(:property, 2)
        get properties_url, params: params.tap { params[:lat] = 'abc' }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
        expect(json[:errors][:lat]).to include(I18n.t('errors.messages.not_a_number'))
      end
    end

    context 'with missing marketing_type parameter' do
      it 'responds with error message' do
        create_list(:property, 2)
        get properties_url, params: params.except(:marketing_type)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
        expect(json[:errors][:marketing_type]).to include(I18n.t('errors.messages.blank'))
      end
    end

    context 'with invalid marketing_type parameter' do
      it 'responds with error message' do
        create_list(:property, 2)
        get properties_url, params: params.tap { params[:marketing_type] = 'abc' }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
        expect(json[:errors][:marketing_type]).to include(I18n.t('errors.messages.inclusion'))
      end
    end

    context 'with missing property_type parameter' do
      it 'responds with error message' do
        create_list(:property, 2)
        get properties_url, params: params.except(:property_type)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
        expect(json[:errors][:property_type]).to include(I18n.t('errors.messages.blank'))
      end
    end

    context 'with invalid property_type parameter' do
      it 'responds with error message' do
        create_list(:property, 2)
        get properties_url, params: params.tap { params[:property_type] = 'abc' }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including('application/json'))
        expect(json[:errors][:property_type]).to include(I18n.t('errors.messages.inclusion'))
      end
    end

    context 'with faraway search location' do
      it 'renders a not found response' do
        create_list(:property, 2)
        get properties_url, params: params.tap { params[:lng] = 0 }
        expect(response).to be_not_found
        expect(response.content_type).to match(a_string_including('application/json'))
        expect(json[:errors]).to include(I18n.t('errors.models.properties/list_properties.not_found'))
      end
    end

    context 'with different marketing_type' do
      it 'renders a not found response' do
        create_list(:property, 2, :sell)
        get properties_url, params: params.tap { params[:marketing_type] = 'rent' }
        expect(response).to be_not_found
        expect(response.content_type).to match(a_string_including('application/json'))
        expect(json[:errors]).to include(I18n.t('errors.models.properties/list_properties.not_found'))
      end
    end

    context 'with different property_type' do
      it 'renders a not found response' do
        create_list(:property, 2, :apartment)
        get properties_url, params: params.tap { params[:property_type] = 'single_family_house' }
        expect(response).to be_not_found
        expect(response.content_type).to match(a_string_including('application/json'))
        expect(json[:errors]).to include(I18n.t('errors.models.properties/list_properties.not_found'))
      end
    end
  end
end
