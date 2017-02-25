json.array!(@withdraws) do |withdraw|
  json.extract! withdraw, :id, :user_id, :date, :amount
  json.url withdraw_url(withdraw, format: :json)
end
