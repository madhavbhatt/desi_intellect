json.array!(@deposits) do |deposit|
  json.extract! deposit, :id, :user_id, :admin_id, :status, :date, :amount
  json.url deposit_url(deposit, format: :json)
end
