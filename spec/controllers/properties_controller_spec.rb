# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PropertiesController, type: :controller do
  describe '#index' do
    subject { get :index, params: params, as: :json }

    before { allow(Properties::ListProperties).to receive(:call).and_return(context) }

    context 'when successful' do
      let(:property) { build(:property) }
      let(:params) { attributes_for(:property).slice(:lat, :lng, :property_type).merge(marketing_type: 'sell') }
      let(:context) { instance_double('context', success?: true, properties: [property]) }

      it { is_expected.to have_http_status(:ok) }
    end

    context 'when unsuccessful' do
      let(:params) { attributes_for(:property).slice(:lat, :lng, :property_type) }
      let(:context) { instance_double('context', success?: false, status: :unprocessable_entity, error: 'Error') }

      it { is_expected.to have_http_status(:unprocessable_entity) }
    end
  end
end
