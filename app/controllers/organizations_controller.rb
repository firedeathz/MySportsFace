class OrganizationsController < ApplicationController
  before_action :logged_in_user, only: [:index, :show]

  def index
	@organizations = Organization.all
  end
  
  def show
    @organization = Organization.find(params[:id])
  end
end
