class Notification < ActiveRecord::Base
  belongs_to :notified_by, class_name: 'User'
  belongs_to :user
  belongs_to :subscribed_user
  belongs_to :post

  validates :user_id, :notified_by_id, :post_id, :identifier, :notice_type, presence: true
  has_many :notifications, dependent: :destroy
  has_many :notifications, dependent: :destroy

end
