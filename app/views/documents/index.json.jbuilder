json.array!(@documents) do |document|
  json.extract! document, :id, :title, :url, :user_id, :category
  json.url document_url(document, format: :json)
end
