json.array!(@borrows) do |borrow|
  json.extract! borrow, :id, :from, :to, :date, :admin_id, :status, :amount, :date
  json.url borrow_url(borrow, format: :json)
end
