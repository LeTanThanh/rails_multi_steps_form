10.times do |i|
  Shipping.create receiver_name: FFaker::Name.name,
  receiver_phone: FFaker::PhoneNumber.phone_number,
  shipping_address: FFaker::Address.street_address,
  shipping_day: FFaker::Time.datetime
end
