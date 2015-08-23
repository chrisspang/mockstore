json.array!(@products) do |product|
  json.extract! product, :id, :name, :description, :available_on, :available_until
  json.url product_url(product, format: :json)
end
