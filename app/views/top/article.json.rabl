object @article
attributes :id, :title, :content
node :created_at do |article|
  article.created_at.to_s(:date)
end

node :tags do |article|
  article.tags.map(&:name)
end
