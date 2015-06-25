class ScheduleEntriesController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]

	def create
		@event = Event.find(params[:event_id])
		@schedule_entry = @event.schedule_entries.create(schedule_entry_params)
		if @schedule_entry.save
			redirect_to event_path(@event)
		else 
			render 'events/show'
		end
	end
	
	def destroy
		@schedule_entry = ScheduleEntry.find(params[:id])
		if @schedule_entry.destroy
			flash[:success] = "Schedule entry successfully deleted"
			redirect_to request.referrer || event_path(@event)
		else
			render 'events/show'
		end
	end

	private
	
		def schedule_entry_params
			params.require(:schedule_entry).permit(:timeloc, :description, :event_id)
		end
end
