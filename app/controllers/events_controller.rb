class EventsController < ApplicationController
	before_action :logged_in_user, only: [:index, :show]
	
	def index
		@user = current_user
		if params[:search]
			@attending = current_user.participations.search(params[:search])
			@events = Event.search(params[:search]).where.not(id: @attending.ids).paginate(page: params[:page])
			if @attending.count < 1 && @events.count < 1
				@noresults = true
				@searched = params[:search]
			else
				@noresults = false
			end
		else
			@attending = current_user.participations
			@events = Event.where.not(id: @attending.ids).paginate(page: params[:page])
		end
	end
	
	def show
		@user = current_user
		@event = Event.find(params[:id])
		@picture = @event.pictures.build if logged_in?
		@video = @event.videos.build if logged_in?
		@schedule_entry = @event.schedule_entries.build if logged_in?
		@participants = @event.participants
		@comments = @event.event_comments
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
	
	def star
		@event = Event.find(params[:id])
		current_user.vote_for(@event)
		redirect_to @event
		flash[:success] = "Successfully starred this event"
	end

	def unstar
		@event = Event.find(params[:id])
		current_user.unvote_for(@event)
		redirect_to @event
		flash[:success] = "Removed your star from this event"
	end
	
	private

		def event_params
			params.require(:event).permit(:name, :summary, :description, :date, :time, :location, :lat, :lng, :user_id)
		end
end
