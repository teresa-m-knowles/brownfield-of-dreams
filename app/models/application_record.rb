# frozen_string_literal: true

# Inherits from Active Record Base. Used to create models
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
