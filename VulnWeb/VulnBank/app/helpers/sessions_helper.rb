module SessionsHelper
	#log in the user
	def log_in(user)
		session[:user_id] = user.id
	end
	
	def current_user?(user)
		user == current_user
	end
	
	#returns the current logged in user if one exists
	def current_user
		@current_user ||= User.find_by(id: session[:user_id])
	end
	
	#returns account owned by current user or all accounts for an admin
	def current_accounts
	  if admin?
	    @current_accounts ||= Account.all.to_a
	  else 
      @current_accounts ||= Account.find_by_sql("SELECT * FROM accounts WHERE owner = name".gsub("name", current_user.id.to_s))
    end
	end
	
	def get_user(id)
	  User.find_by_sql("SELECT * FROM users WHERE id = number".gsub("number",id.to_s))
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
	
	def admin?
		current_user.admin?
	end
end
