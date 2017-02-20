class UsersController < ApplicationController
	before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
	before_action :correct_user, only: [:edit, :update]
	before_action :is_admin?, only: [:destroy]

  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Account creation successful! Welcome to the Bank of Bogus Transactions!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Account update successful!"
      redirect_to @user
	  else
	    render 'edit'
	  end
  end
  
  def destroy
	User.find(params[:id]).destroy
	flash[:success] = "User Deleted"
	redirect_to users_url
  end
  
  def index
	@users = []
	
	if current_user.admin?
		if params[:search]
			@users = User.search(params[:search]).paginate(page: params[:page])
		else
			@users = User.paginate(page: params[:page])
		end
		if @users.empty?
			flash.now[:danger] = "No Results Found"
		end
	else
		if params[:search]
			if params[:search].blank?
				@users = []
			else
				@users = User.search(params[:search]).paginate(page: params[:page])
			end
			if @users.empty?
				flash.now[:danger] = "No Results Found"
			end
		else
			@users = []
		end
	end
  end
  
  private
  
	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end
	
	def logged_in_user
		unless logged_in?
			
			flash[:danger] = "Please log in."
			redirect_to login_url
		end
	end
	
	def correct_user
		@user = User.find(params[:id])
		redirect_to(root_url) unless current_user?(@user)
	end
	
	def is_admin?
		redirect_to(root_url) unless current_user.admin?
	end
end
