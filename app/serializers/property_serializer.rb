# frozen_string_literal: true

# JSON Serializer for Property object
class PropertySerializer
  include JSONAPI::Serializer
  attributes :house_number, :street, :city, :zip_code, :lat, :lng, :price
end
