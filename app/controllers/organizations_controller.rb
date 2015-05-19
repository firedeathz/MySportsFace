class OrganizationsController < ApplicationController
  before_action :logged_in_user, only: [:index, :show]

  def index
	@organizations = Organization.all
  end
  
  def show
    @organization = Organization.find(params[:id])
	@feed = @organization.feed
	body, ok = SuperfeedrEngine::Engine.subscribe(@feed, {:retrieve => true})
	if !ok
		
	else
		@feed.notified JSON.parse(body)
	end
  end
end
