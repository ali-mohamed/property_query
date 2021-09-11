# frozen_string_literal: true

# Property class
class Property < ApplicationRecord
  acts_as_geolocated

  enum property_type: { apartment: 'apartment', single_family_house: 'single_family_house' }
  enum offer_type: { sell: 'sell', rent: 'rent' }
end
