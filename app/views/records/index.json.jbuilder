json.array!(@records) do |record|
  json.extract! record, :key, :value
  json.url record_url(record, format: :json)
end
