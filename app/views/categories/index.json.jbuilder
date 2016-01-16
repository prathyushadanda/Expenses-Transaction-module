json.array!(@catagories) do |catagory|
  json.extract! catagory, :id, :source, :description, :user_id, :type
  json.url catagory_url(catagory, format: :json)
end
