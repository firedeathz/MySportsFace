class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :following, :followers]
  before_action :correct_user,   only: [:edit, :update]

  def index
    @user = current_user
	if params[:search]
		@users = User.search(params[:search]).paginate(page: params[:page])
		if @users.count < 1
			@noresults = true
			@searched = params[:search]
		else
			@noresults = false
		end
	else
		@users = User.paginate(page: params[:page])
	end
  end
  
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
	@micropost = current_user.microposts.build if logged_in?
	@microposts = @user.microposts.paginate(page: params[:page], :per_page => 15)
	@events = @user.events.paginate(page: params[:page], :per_page => 10)
  end
  
  def create
    @user = User.find_by(email: user_params[:email])
	if @user
		if @user.identities.find_by_provider("mysportsface").nil?
			identity = Identity.new
			identity.user = @user
			identity.provider = "mysportsface"
			identity.uid = rand().to_s
			identity.save!
			@user.password = user_params[:password]
			if @user.save!
				session[:user_id] = @user.id
				flash[:success] = "Welcome! Your account has been linked with either of your Facebook and/or Google+ accounts."
				redirect_to @user
			else
				render 'new'
			end
		else
			flash[:error] = "An account with that email already exists."
			redirect_to signup_path
		end
	else
		@user = User.new(user_params)
		identity = Identity.new
		identity.user = @user
		identity.provider = "mysportsface"
		identity.uid = rand().to_s
		identity.save!
		if @user.save
		  session[:user_id] = @user.id
		  flash[:success] = "Welcome to the MySportsFace community, " + @user.name + "!"
		  redirect_to @user
		else
		  render 'new'
		end
	end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Your profile has been updated."
      redirect_to @user
    else
      render 'edit'
    end
  end  
  
  def edit
    @user = User.find(params[:id])
  end
  
  def participations
	@title = "Attending"
	@user = User.find(params[:id])
	@events = @user.participations
	render 'show_participations'
  end
  
  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  private

	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation, :uid, :provider, :oauth_token, :oauth_expires_at)
	end
	
	def correct_user
	  @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
	end
end
