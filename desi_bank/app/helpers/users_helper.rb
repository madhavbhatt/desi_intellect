module UsersHelper
	def gravatar_for(user, options = { size: 80 })
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		size = options[:size]
		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
		image_tag(gravatar_url, alt: user.name, class: "gravatar")
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
end
