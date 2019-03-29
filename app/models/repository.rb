# frozen_string_literal: true

# Repository PORO Class. It refers to a Github repository.
class Repository
  attr_reader :name,
              :address

  def initialize(data)
    @name = data[:name]
    @address = data[:html_url]
  end
end
