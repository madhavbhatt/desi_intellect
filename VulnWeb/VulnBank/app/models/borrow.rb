class Borrow < ActiveRecord::Base
	belongs_to :user
	belongs_to :friend, class_name: "User", foreign_key: "friend_id"

	validates :requestor, presence: true
	validates :requestee, presence: true

	def self.request(p)
		unless p[:requestor] == p[:requestee]
			transaction do
				create(to_account: p[:to_account], from_account: p[:from_account], amount: p[:amount], status: 'pending', requestor: p[:requestor], requestee: p[:requestee])
			end
		end
	end
end
