# frozen_string_literal: true

Rails.application.routes.draw do
  defaults format: :json do
    resources :properties, only: %i[index]
  end
end
