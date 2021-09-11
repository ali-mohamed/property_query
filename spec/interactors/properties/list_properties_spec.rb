# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'failed interactor' do
  it 'fails' do
    expect(context).to be_a_failure
  end

  it 'provides an error message' do
    expect(context.error).to be_present
  end

  it 'provides a status code' do
    expect(context.status).to be_present
  end
end

RSpec.describe Properties::ListProperties do
  describe 'call' do
    subject(:context) { described_class.call(params) }

    let(:params) { attributes_for(:property).slice(:lat, :lng, :property_type).merge(marketing_type: 'sell') }

    context 'with valid params' do
      let!(:property) { create(:property) }

      it 'succeeds' do
        expect(context).to be_a_success
      end

      it 'assigns the properties' do
        expect(context.properties).to eq([property])
      end
    end

    context 'with missing longitude parameter' do
      before { params[:lng] = nil }

      it_behaves_like 'failed interactor'
    end

    context 'with missing latitude parameter' do
      before { params[:lat] = nil }

      it_behaves_like 'failed interactor'
    end

    context 'with missing property type parameter' do
      before { params[:property_type] = nil }

      it_behaves_like 'failed interactor'
    end

    context 'with missing marketing type parameter' do
      before { params[:marketing_type] = nil }

      it_behaves_like 'failed interactor'
    end

    context 'with invalid longitude parameter' do
      before { params[:lng] = 'abc' }

      it_behaves_like 'failed interactor'
    end

    context 'with invalid latitude parameter' do
      before { params[:lat] = 'abc' }

      it_behaves_like 'failed interactor'
    end

    context 'with invalid property type parameter' do
      before { params[:property_type] = 'abc' }

      it_behaves_like 'failed interactor'
    end

    context 'with invalid marketing type parameter' do
      before { params[:marketing_type] = 'abc' }

      it_behaves_like 'failed interactor'
    end

    context 'when no data found' do
      it_behaves_like 'failed interactor'
    end
  end
end
