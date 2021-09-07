# frozen_string_literal: true

# ApplicationRecord, abstract class
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
