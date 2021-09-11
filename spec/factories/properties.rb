# frozen_string_literal: true

FactoryBot.define do
  factory :property do
    house_number { 3642 }
    street { 'Hemlock Lane' }
    city { 'Berlin' }
    zip_code { '10243' }
    lat { 52.53 }
    lng { 13.42 }
    property_type { 'apartment' }
    offer_type { 'sell' }
    price { 12_000 }
  end
end
