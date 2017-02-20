class Account < ActiveRecord::Base
  validates :acct_number, presence: true, length: {is: 9}, uniqueness: true
  validates :status, inclusion: %w(active closed) 
end
