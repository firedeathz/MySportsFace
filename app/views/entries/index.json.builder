json.array!(@entries) do |entry|
  json.extract! entry, :id, :feed_id, :atom_id, :title, :url, :content, :description
  json.url entry_url(entry, format: :json)
end