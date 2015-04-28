class PicturesController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]

	def create
		@event = Event.find(params[:event_id])
		@picture = @event.pictures.build(picture_params)
		if @picture.save
			flash[:success] = "Successfully uploaded your photo!"
			redirect_to @event
		else
			render 'events/show'
		end
	end
	
	private

		def picture_params
			params.require(:picture).permit(:url, :event_id)
		end
end
