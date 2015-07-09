class ArticlesController < ApplicationController
  before_action :logged_in_user, only: [:index, :show]

  def index
	@user = current_user
	@organization = Organization.find(params[:id])
	if params[:search]
		@articles = @organization.articles.search(params[:search]).order("created_at DESC").paginate(page: params[:page])
		if @articles.count < 1
			@noresults = true
			@searched = params[:search]
		else
			@noresults = false
		end
	else
		@articles = @organization.articles.paginate(page: params[:page])
	end
  end
  
  def show
	@user = current_user
	@article = Article.find(params[:id])
	@organization = Organization.find(@article.organization_id)
	@comments = @article.comments
  end
  
  def star
	@article = Article.find(params[:id])
	current_user.vote_for(@article)
	redirect_to @article
	flash[:success] = "Successfully starred this article"
  end
  
  def unstar
	@article = Article.find(params[:id])
	current_user.unvote_for(@article)
	redirect_to @article
	flash[:warning] = "Removed your star from this article"
  end
end
