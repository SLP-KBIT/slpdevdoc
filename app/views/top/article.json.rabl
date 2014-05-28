object @article
attributes :id, :title, :content
node :created_at do |article|
  article.created_at.to_s(:date)
end

child :tags , object_root: false do |ch|
  attributes name: :text
end
