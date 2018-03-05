class Transfer < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: "User", foreign_key: "friend_id"

  validates :from, presence: true
  validates :to, presence: true

  def self.request(p, sender, friend)
    startdate = Date.new(p["start(1i)"].to_i, p["start(2i)"].to_i, p["start(3i)"].to_i)
	effectivedate = Date.new(p["effective(1i)"].to_i, p["effective(2i)"].to_i, p["effective(3i)"].to_i)
    unless p[:to] == p[:from]
      transaction do
        create(from: p[:from], to: p[:to], amount: p[:amount], status: 'complete', sender: sender, recipient: friend, start: startdate, effective: effectivedate)
      end
    end
  end
end
