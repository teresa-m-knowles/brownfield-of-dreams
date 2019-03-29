# frozen_string_literal: true

# Represents a github repository PORO
class Repository
  attr_reader :name,
              :address

  def initialize(data)
    @name = data[:name]
    @address = data[:html_url]
  end
end
