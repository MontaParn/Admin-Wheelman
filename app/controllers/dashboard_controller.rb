class DashboardController < ApplicationController
  def index
    @memberships = Membership.expiring_soon.includes(:athlete, :package_plan).order(:end_date)
  end
end
