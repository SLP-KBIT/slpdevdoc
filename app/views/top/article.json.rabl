object @article
attributes :id, :title, :content#, created_at: lambda { |c| c.to_s}
node :created_at do |article|
  article.created_at.to_s(:date)
end

#child :tags , object_root: false do
#      attributes :name
#end

#collection @article.tags
node :tags do |article|
  article.tags.map(&:name)
end