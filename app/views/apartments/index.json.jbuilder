json.array!(@apartments) do |apartment|
  json.extract! apartment, :id, :title, :description, :cost, :deposit, :currency, :user_id, :males, :females, :address, :lat, :lng, :created_at, :from, :until, :phone, :male_or_female
  json.url apartment_url(apartment, format: :json)
end
