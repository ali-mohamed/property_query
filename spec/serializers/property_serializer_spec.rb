# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'serialized property' do
  it 'shows house number' do
    expect(json[:house_number]).to eq(property.house_number)
  end

  it 'shows street' do
    expect(json[:street]).to eq(property.street)
  end

  it 'shows city' do
    expect(json[:city]).to eq(property.city)
  end

  it 'shows zip code' do
    expect(json[:zip_code]).to eq(property.zip_code)
  end

  it 'shows latitude' do
    expect(json[:lat]).to eq(property.lat)
  end

  it 'shows longitude' do
    expect(json[:lng]).to eq(property.lng)
  end

  it 'shows price' do
    expect(json[:price]).to eq(property.price)
  end
end

RSpec.describe PropertySerializer do
  let(:property) { build(:property) }

  describe 'when property' do
    subject { described_class.new(property).serializable_hash }

    let(:json) { subject[:data][:attributes] }

    it_behaves_like 'serialized property'
  end

  describe 'when list of properties' do
    subject { described_class.new([property]).serializable_hash }

    let(:data) { subject[:data] }
    let(:json) { data[0][:attributes] }

    it 'shows serialized array with same length as properies list' do
      expect(data.count).to eq(1)
    end

    it_behaves_like 'serialized property'
  end
end
