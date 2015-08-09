json.array!(@documents) do |document|
  json.extract! document, :id, :name, :content, :comment, :tag, :project_id
  json.upload_path document.file
  json.filename document.filename
end