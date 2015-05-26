class ScheduleEntriesController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]

	def create
		@event = Event.find(params[:event_id])
		@schedule_entry = @event.schedule_entries.build(schedule_entry_params)
		if @schedule_entry.save
			redirect_to @event
		else 
			render 'events/show'
		end
	end

	private
	
		def schedule_entry_params
			params.require(:schedule_entry).permit(:timeloc, :description, :event_id)
		end
end
