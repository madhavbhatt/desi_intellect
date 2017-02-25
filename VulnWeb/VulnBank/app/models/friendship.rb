class Friendship < ActiveRecord::Base
	belongs_to :user
	belongs_to :friend, class_name: "User", foreign_key: "friend_id"
	
	validates :user_id, presence: true
	validates :friend_id, presence: true
	
	def self.exists?(user, friend)
		not find_by_user_id_and_friend_id(user, friend).nil?
	end
	
	def self.request(user, friend)
		unless user == friend or Friendship.exists?(user, friend)
			transaction do
				create(user: user, friend: friend, status: 'requested')
				create(user: friend, friend: user, status: 'pending')
			end
		end
	end
	
	def self.accept(user, friend)
		transaction do
			accept_one_side(user, friend)
			accept_one_side(friend, user)
		end
	end
	
	def self.breakup(user, friend)
		transaction do
			destroy(find_by_user_id_and_friend_id(user, friend))
			destroy(find_by_user_id_and_friend_id(friend, user))
		end
	end
	
	private
	
		def self.accept_one_side(user, friend)
			request = find_by_user_id_and_friend_id(user, friend)
			request.status = 'accepted'
			request.save!
		end
			
end
