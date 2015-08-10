json.array!(@bookmarks) do |bookmark|
  json.extract! bookmark, :id, :color, :document_id, :user_id, :created_at, :updated_at
end