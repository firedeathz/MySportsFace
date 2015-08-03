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
			flash[:notice] = "Your comment has been deleted."
			redirect_to request.referrer || event_path(@event)
		else
			render 'events/show'
		end
	end
	
	def star
		@comment = EventComment.find(params[:id])
		current_user.vote_for(@comment)
		redirect_to Event.find(@comment.event_id)
		flash[:success] = "Successfully starred the comment."
	end

	def unstar
		@comment = EventComment.find(params[:id])
		current_user.unvote_for(@comment)
		redirect_to Event.find(@comment.event_id)
		flash[:success] = "Removed your star from the comment."
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
