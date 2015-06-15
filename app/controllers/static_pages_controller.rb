class StaticPagesController < ApplicationController
  before_action :admin_user, only: [:admin_board]
	
  def home
	@user = current_user
    @micropost = current_user.microposts.build if logged_in?
	@feed_items = current_user.feed.paginate(page: params[:page]) if logged_in?
  end
  
  def help
  end
  
  def admin_board
	@user = current_user
  end
  
  private 
  
	def admin_user
		if current_user.nil?
			redirect_to login_url
			flash[:danger] = "Please log in to access this page."
		else
			if !current_user.admin?
				redirect_to login_url
				flash[:danger] = "You do not have the rights to access this page. Please log in with an administrator account."
			end
		end
	end
end
