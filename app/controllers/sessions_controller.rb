class SessionsController < ApplicationController
  def new
  end
  
  def create
	user = User.find_for_oauth(env["omniauth.auth"])
	log_in user
	redirect_back_or root_path
  end
  
  def create_identity
	user = User.find_by(email: params[:session][:email].downcase)
	if user && Identity.find_by(user: user.id, provider: "mysportsface").nil?
	  flash.now[:error] = 'Invalid email or password.'
      render 'new'
	elsif user && user.authenticate(params[:session][:password])
      log_in user
	  params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or root_path
	  flash.now[:success] = "Welcome back to MySportsFace, " + user.name + "!"
    else
      flash.now[:error] = 'Invalid email or password.'
      render 'new'
    end
  end

  def destroy
	session[:user_id] = nil
    redirect_to root_url  
  end
end
