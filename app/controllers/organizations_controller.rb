class OrganizationsController < ApplicationController
  before_action :logged_in_user, only: [:index, :show]

  def index
	@user = current_user
	@favorites = current_user.favorite_organizations
	@organizations = Organization.where.not(id: @favorites.ids)
  end
  
  def new
	@organization = Organization.new
  end
  
  def create
	@organization = Organization.new(organization_params)
    if @organization.save
	  flash[:success] = "Successfully created a new organization."
      redirect_to admin_board_path
    else
      render 'new'
    end
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
  
  private
  
	def organization_params
		params.require(:organization).permit(:name, :description, :logo, :url, feed_attributes: [:title, :url, :status])
	end
	
	def feed_params
		params.require(:feed).permit(:title, :url, :status)
	end
end
