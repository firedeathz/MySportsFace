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
		flash[:success] = "Comment successfully deleted"
		redirect_to request.referrer || article_path(@article)
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
