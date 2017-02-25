class Transaction < ActiveRecord::Base
    validates :status, inclusion: %w(approved declined pending) 
end
