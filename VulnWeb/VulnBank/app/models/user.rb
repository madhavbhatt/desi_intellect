class User < ActiveRecord::Base
	before_save { email.downcase! }
	validates :name, presence: true, length: {maximum: 20 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 40 }, format: { with: VALID_EMAIL_REGEX },
					  uniqueness: { case_sensitive: false }
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
	
	has_many :friendships
	has_many :friends, through: :friendships, validate: "status = 'accepted'"
	has_many :requested_friends, through: :friendships, source: :friend, validate: "status = 'requested'"
	has_many :pending_friends, through: :friendships, source: :friend, validate: "status = 'pending'"
	
	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end
	
	def self.search(search)
		if search
			where("name LIKE ? OR email LIKE ?", "%#{search}%", "%#{search}%")
		else
			[]
		end
	end
end
