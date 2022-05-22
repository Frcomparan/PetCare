json.extract! notification, :id, :recipient_id, :read_at, :notifiable_type
json.url notification_url(pet, format: :json)
