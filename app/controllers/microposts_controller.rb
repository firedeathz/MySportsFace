class MicropostsController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy, :star, :unstar]
	before_action :correct_user,   only: :destroy

	def create
		@micropost = current_user.microposts.build(micropost_params)
		if @micropost.save
			flash[:success] = "Post created."
			redirect_to root_url
		else
			@feed_items = current_user.feed.paginate(page: params[:page]) if logged_in?
			@user = current_user
			render 'static_pages/home'
		end
	end

	def destroy
		@micropost.destroy
		flash[:notice] = "Your post has been deleted."
		redirect_to request.referrer || root_url		
	end
	
	def star
		@micropost = Micropost.find(params[:id])
		current_user.vote_for(@micropost)
		redirect_to root_url
		flash[:success] = "Successfully starred the post."
	end

	def unstar
		@micropost = Micropost.find(params[:id])
		current_user.unvote_for(@micropost)
		redirect_to root_url
		flash[:notice] = "Removed your star from the post."
	end
	
	private

		def micropost_params
			params.require(:micropost).permit(:content, :picture)
		end
		
		def correct_user
			@micropost = current_user.microposts.find_by(id: params[:id])
			redirect_to root_url if @micropost.nil?
		end
end
