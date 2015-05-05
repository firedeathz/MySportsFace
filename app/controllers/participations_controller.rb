class ParticipationsController < ApplicationController

	def create
		event = Event.find(params[:event_id])
		current_user.participate(event, false, false)
		flash[:success] = "Successfully signed up for this event!"
		redirect_to event
	end
	
	def update
		@participation = Participation.find(params[:id])
		if @participation.admin?
			@participation.update_attributes(admin: false)
		else 
			@participation.update_attributes(admin: true)
		end
		redirect_to @participation.event
	end
	
	def destroy
		event = Participation.find(params[:id]).event
		current_user.remove_participation(event)
		flash[:success] = "You are now unsigned for this event."
		redirect_to event
	end
	
	private
		
		def participation_params
			params.require(:participation).permit(:event_id, :user_id, :admin)
		end

end
