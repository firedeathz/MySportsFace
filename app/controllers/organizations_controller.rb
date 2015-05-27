class OrganizationsController < ApplicationController
  before_action :logged_in_user, only: [:index, :show]

  def index
	@user = current_user
	@favorites = current_user.favorite_organizations
	@organizations = Organization.where.not(id: @favorites.ids)
  end
  
  def show
    @user = current_user
    @organization = Organization.find(params[:id])
	@feed = @organization.feed
	body, ok = SuperfeedrEngine::Engine.subscribe(@feed)
	body, ok = SuperfeedrEngine::Engine.retrieve(@feed, :count => "20")
	if !ok
	else
		@feed.notified JSON.parse(body)
	end
  end
end
