json.array!(@variants) do |variant|
  json.extract! variant, :id, :sku, :is_master, :price, :position, :product_id
  json.url variant_url(variant, format: :json)
end
