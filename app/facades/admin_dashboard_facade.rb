# frozen_string_literal: true

# Facade for the Admin dashboard
class AdminDashboardFacade
  def tutorials
    Tutorial.all
  end
end
