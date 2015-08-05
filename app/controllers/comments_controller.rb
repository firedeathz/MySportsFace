class CommentsController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]
	before_action :correct_user,   only: :destroy

	def create
		@article = Article.find(params[:article_id])
		@comment = @article.comments.create(comment_params)
		redirect_to article_path(@article)
	end
	
	def destroy
		@comment.destroy
		flash[:success] = "Your comment has been deleted."
		redirect_to request.referrer || article_path(@article)
	end
	
	def star
		@comment = Comment.find(params[:id])
		current_user.vote_for(@comment)
		redirect_to Article.find(@comment.article_id)
		flash[:success] = "Successfully starred the comment."
	end

	def unstar
		@comment = Comment.find(params[:id])
		current_user.unvote_for(@comment)
		redirect_to Article.find(@comment.article_id)
		flash[:notice] = "Removed your star from the comment."
	end
	
	private
		
		def comment_params
			params.require(:comment).permit(:author, :user_id, :article_id, :body)
		end
		
		def correct_user
			@comment = current_user.comments.find_by(id: params[:id])
			redirect_to article_path(@article) if @comment.nil?
		end
end
