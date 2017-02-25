json.array!(@notifications) do |notification|
  json.extract! notification, :id, :user_id, :subscribed_user_id, :post_id, :identifier, :type, :read
  json.url notification_url(notification, format: :json)
end
