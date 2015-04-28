class ArticlesController < ApplicationController
  before_action :logged_in_user, only: [:index, :show]

  def index
	@organization = Organization.find(params[:id])
	@articles = @organization.articles
  end
  
  def show
	@user = current_user
	@article = Article.find(params[:id])
	@organization = Organization.find(@article.organization_id)
	@comments = @article.comments
  end
end
