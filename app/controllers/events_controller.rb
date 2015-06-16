class EventsController < ApplicationController
	before_action :logged_in_user, only: [:index, :show]
	
	def index
		@user = current_user
		@attending = current_user.participations
		@events = Event.paginate(page: params[:page]).where.not(id: @attending.ids)
	end
	
	def show
		@user = current_user
		@event = Event.find(params[:id])
		@picture = @event.pictures.build if logged_in?
		@video = @event.videos.build if logged_in?
		@schedule_entry = @event.schedule_entries.build if logged_in?
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
			params.require(:event).permit(:name, :summary, :description, :date, :time, :location, :lat, :lng, :user_id)
		end
end
