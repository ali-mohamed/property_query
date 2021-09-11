# frozen_string_literal: true

module Properties
  # List Properties withing 5 kilometer radius
  class ListProperties
    include Interactor
    include ActiveModel::Validations

    SEARCH_RADIUS = 5000

    delegate :lng, :lat, :property_type, :marketing_type, to: :context

    validates :lng, presence: true, numericality: { allow_blank: true }
    validates :lat, presence: true, numericality: { allow_blank: true }
    validates :property_type, presence: true,
                              inclusion: { in: Property.property_types.keys, allow_blank: true }
    validates :marketing_type, presence: true,
                               inclusion: { in: Property.offer_types.keys, allow_blank: true }

    def call
      validate_search_parameters
      context.properties = load_properties
      no_data_found_notification if context.properties.blank?
    end

    private

    def validate_search_parameters
      context.fail!(error: errors, status: 422) unless valid?
    end

    def load_properties
      Property.where(offer_type: marketing_type, property_type: property_type)
              .within_radius(SEARCH_RADIUS, lat, lng)
    end

    def no_data_found_notification
      context.fail!(error: I18n.t('errors.models.properties/list_properties.not_found'), status: 404)
    end
  end
end
