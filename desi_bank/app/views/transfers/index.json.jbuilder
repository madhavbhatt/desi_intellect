json.array!(@transfers) do |transfer|
  json.extract! transfer, :id, :from, :to, :amount, :start, :effective
  json.url transfer_url(transfer, format: :json)
end
