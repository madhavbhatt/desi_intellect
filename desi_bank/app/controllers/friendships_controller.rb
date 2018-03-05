class FriendshipsController < ApplicationController
	helper :users
	include UsersHelper
	
	before_filter :setup_friends
	
	def create
		if @friend.nil?
			flash[:danger] = "Friend is Nil"
		else
			Friendship.request(@user, @friend)
			flash[:success] = "Friend request sent."
		end
		
		redirect_to :back
	end
	
	def accept
		if @user.requested_friends.include?(@friend)
			Friendship.accept(@user, @friend)
			flash[:success] = "Friendship Accepted"
		else
			flash[:danger] = "No Request Available from #{@friend.name}"
		end
		
		redirect_to :back
	end
	
	def decline
		if @user.requested_friends(@friend)
			Friendship.breakup(@user, @friend)
			flash[:success] = "Request Declined"
		else
			flash[:danger] = "No Request Available"
		end
		
		redirect_to :back
	end
	
	def cancel
		if @user.pending_friends.include?(@friend)
			Friendship.breakup(@user, @friend)
			flash[:notice] = "Friend Request Canceled"
		else
			flash[:notice] = "No Request Available"
		end
		
		redirect_to :back
	end
	
	def delete
		if @user.friends.include?(@friend)
			Friendship.breakup(@user, @friend)
			flash[:notice] = "Friend Removed"
		else
			flash[:notice] = "No Friendship Exists"
		end
		
		redirect_to :back
	end
	
	private
	
		def setup_friends
			@user = User.find(session[:user_id])
			@friend = User.find(params[:friend_param])
		end
end
