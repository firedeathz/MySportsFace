class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  helper_method :current_user
  
  private
	
	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end
	
	def logged_in_user
      unless logged_in?
	    store_location
        flash[:danger] = "Please log in to access this page."
        redirect_to login_url
      end
    end
end
