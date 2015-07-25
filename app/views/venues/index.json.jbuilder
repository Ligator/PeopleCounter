json.array!(@venues) do |venue|
  json.extract! venue, :id, :counter, :name
  json.url venue_url(venue, format: :json)
end
