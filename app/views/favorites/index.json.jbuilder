json.array!(@favorites) do |favorite|
  json.extract! favorite, :id, :comment
  json.url favorite_url(favorite, format: :json)
end
