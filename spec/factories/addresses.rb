FactoryBot.define do
  factory :address do
    address_id Faker::Number.number(11)
    zipcode Faker::Address.postcode
    house_name_or_number "{\"house_number\":\"44\",\"property_name\":null,\"street_number\":\"44\"}"
    street_name "{\"street_name\":\"BUNDARRA\",\"street_type\":\"AVE\",\"street_suffix\":\"N\"}"
    lot_or_unit "{\"lot\":null,\"unit\":null,\"floor\":null}"
    summary 'test summary'
  end
end
