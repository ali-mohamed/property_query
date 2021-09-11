# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Property, type: :model do
  subject { build(:property) }

  it { is_expected.to have_attribute :house_number }
  it { is_expected.to have_attribute :street }
  it { is_expected.to have_attribute :city }
  it { is_expected.to have_attribute :zip_code }
  it { is_expected.to have_attribute :lat }
  it { is_expected.to have_attribute :lng }
  it { is_expected.to have_attribute :property_type }
  it { is_expected.to have_attribute :offer_type }
  it { is_expected.to have_attribute :price }

  # Enums
  describe '.property_types' do
    subject { described_class.property_types }

    it { is_expected.to eq('apartment' => 'apartment', 'single_family_house' => 'single_family_house') }
  end

  describe '.offer_types' do
    subject { described_class.offer_types }

    it { is_expected.to eq('rent' => 'rent', 'sell' => 'sell') }
  end
end
