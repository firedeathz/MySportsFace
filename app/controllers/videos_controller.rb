class VideosController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]

	def create
		@event = Event.find(params[:event_id])
		@video = @event.videos.build(video_params)
		if @video.save
			flash[:success] = "Successfully added your video!"
			redirect_to @event
		else
			redirect_to @event
			flash[:notice] = "Failed to add your video. Link is invalid."
		end
	end

	private
	
		def video_params
			params.require(:video).permit(:link, :event_id)
		end

end
