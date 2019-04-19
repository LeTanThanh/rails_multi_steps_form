json.extract! shipping, :id, :receiver_name, :receiver_phone, :shipping_address, :shipping_day, :created_at, :updated_at
json.url shipping_url(shipping, format: :json)
