json.array!(@option_values) do |option_value|
  json.extract! option_value, :id, :name, :presentation, :position, :option_type_id
  json.url option_value_url(option_value, format: :json)
end
