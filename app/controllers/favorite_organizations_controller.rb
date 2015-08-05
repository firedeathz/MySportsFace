class FavoriteOrganizationsController < ApplicationController
	before_action :set_organization
	
	def create
		if Favorite.create(favorited: @organization, user: current_user)
			redirect_to @organization
			flash[:success] = "Successfully added the organization to your favorites."
		end
	end
	
	def destroy
		Favorite.where(favorited_id: @organization.id, user_id: current_user.id).first.destroy
		redirect_to @organization
		flash[:notice] = "Removed the organization from your favorites."
	end
	
	private
	
		def set_organization
			@organization = Organization.find(params[:organization_id] || params[:id])
		end
end
