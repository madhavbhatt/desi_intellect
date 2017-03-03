json.array!(@withdrawals) do |withdrawal|
  json.extract! withdrawal, :id, :user_id, :date, :amount
  json.url withdrawal_url(withdrawal, format: :json)
end
