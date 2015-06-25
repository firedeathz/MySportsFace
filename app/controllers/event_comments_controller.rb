class EventCommentsController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]
	before_action :correct_user,   only: :destroy
	
	def create
		@event = Event.find(params[:event_id])
		@comment = @event.event_comments.create(comment_params)
		if @comment.save
			redirect_to event_path(@event)
		else 
			render 'events/show'
		end
	end
	
	def destroy
		@comment = EventComment.find(params[:id])
		if @comment.destroy
			flash[:success] = "Comment successfully deleted"
			redirect_to request.referrer || event_path(@event)
		else
			render 'events/show'
		end
	end
	
	private
		
		def comment_params
			params.require(:event_comment).permit(:author, :user_id, :event_id, :body)
		end
		
		def correct_user
			@comment = current_user.event_comments.find_by(id: params[:id])
			redirect_to event_path(@event) if @comment.nil?
		end
end
