class FeedsController < ApplicationController
	before_action :set_feed, only: [:show, :retrieve]

	def index
		@organization = Organization.find(params[:organization_id])
		@feed = @organization.feed
	end
	
	def show
	end
	
	def edit
	end
	
	def retrieve
		body, ok = SuperfeedrEngine::Engine.subscribe(@feed)
		if !ok
			redirect_to organization_feeds_path(@organization)
			flash[:error] = "Error subscribing to the feed."
		else
			redirect_to organization_feeds_path(@organization)
			flash[:success] = "Successfully subscribed to the feed."
		end
		body, ok = SuperfeedrEngine::Engine.retrieve(@feed)
		if !ok
			flash[:error] = "Failed to subscribe to the feed."
		else
			@feed.notified JSON.parse(body)
		end
	end
	
	private
	
		def set_feed
			@organization = Organization.find(params[:organization_id])
			@feed = @organization.feed
		end
		
		def feed_params
			params.require(:feed).permit(:title, :url)
		end
end
