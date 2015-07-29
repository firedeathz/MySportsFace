class PicturesController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]
	before_action :picture_exists,   only: :destroy
	
	def create
		@event = Event.find(params[:event_id])
		@picture = @event.pictures.build(picture_params)
		if @picture.save
			flash[:success] = "Successfully uploaded your photo!"
			redirect_to @event
		else
			redirect_to @event
			flash[:notice] = "Failed to upload your picture."
		end
	end
	
	def destroy
		@picture.destroy
		flash[:notice] = "Picture removed successfully."
		redirect_to request.referrer || event_path(@event)
	end	
	
	private

		def picture_params
			params.require(:picture).permit(:url, :event_id)
		end
		
		def picture_exists
			@picture = Picture.find_by(id: params[:id])
			redirect_to events_path if @picture.nil?
		end
end
