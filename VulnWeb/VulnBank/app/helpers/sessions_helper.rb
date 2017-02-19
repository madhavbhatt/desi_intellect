module SessionsHelper
	#log in the user
	def log_in(user)
		session[:user_id] = user.id
	end
	
	#returns the current logged in user if one exists
	def current_user
		@current_user ||= User.find_by(id: session[:user_id])
	end
	def logged_in?
		!current_user.nil?
	end
	
	def log_out
		session.delete(:user_id)
		@current_user = nil
	end
	
	def redirect_back_or(default)
		redirect_to(session[:forwarding_url] || default)
		session.delete(:forwarding_url)
	end
	
	def store_location
		session[:forwarding_url] = request.original_url if request.get?
	end
end
