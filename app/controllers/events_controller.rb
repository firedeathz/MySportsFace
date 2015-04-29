class EventsController < ApplicationController
	before_action :logged_in_user, only: [:index, :show]
	
	def index
		@events = Event.paginate(page: params[:page])
	end
	
	def show
		@event = Event.find(params[:id])
		@picture = @event.pictures.build if logged_in?
		@participants = @event.participants
	end
	
	def new
		@event = Event.new
	end
	
	def create
		@event = Event.new(event_params)
		if @event.save
			flash[:success] = "Successfully created a new event!"
			@event.add_participant(current_user, false, true)
			redirect_to @event
		else
			render 'new'
		end
	end
	
	private

		def event_params
			params.require(:event).permit(:name, :description, :user_id)
		end
end