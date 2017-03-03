class Deposit < ActiveRecord::Base
  belongs_to :user
  belongs_to :admin, class_name: "User", foreign_key: "admin_id"

  validates :user_id, presence: true

  def self.request(user, admin)
    unless user == admin
      transaction do
        create(user: user, admin: admin, status: 'requested')
        create(user: admin, admin: user, status: 'pending')
      end
    end
  end

  def self.accept(user, admin)
    transaction do
      accept_one_side(user, admin)
      accept_one_side(admin, user)
    end
  end

  def self.breakup(user, admin)
    transaction do
      destroy(find_by_user_id_and_admin_id(user, admin))
      destroy(find_by_user_id_and_admin_id(admin, user))
    end
  end

private

def self.accept_one_side(user, admin)
  request = find_by_user_id_and_admin_id(user, admin)
  request.status = 'accepted'
    request.save!
  end
end
