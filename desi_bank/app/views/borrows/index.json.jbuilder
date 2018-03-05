json.array!(@borrows) do |borrow|
  json.extract! borrow, :id, :user_id, :friend_id, :status, :date, :amount
  json.url borrow_url(borrow, format: :json)
end
