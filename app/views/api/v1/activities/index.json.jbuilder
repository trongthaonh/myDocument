json.array!(@activities) do |activity|
  json.extract! activity, :id, :owner_id, :key, :created_at, :updated_at
end