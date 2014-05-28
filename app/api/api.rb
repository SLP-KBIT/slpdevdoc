class API < Grape::API
  format :json
  formatter :json, Grape::Formatter::Rabl
  prefix "api"

  helpers do
    def article_params
      params.slice( :title, :content)
    end

    def logger
      API.logger
    end
  end

  resource :article do
    desc "return articles"
    get '/', rabl: 'articles.json' do
      @articles = Article.all.includes(:tags) #.limit(10)
    end

    desc "return a article"
    params do
      requires :id, type: Integer, desc: "Article id"
    end
    route_param :id do
      get do
        Article.where(id: params[:id]).first
      end
    end

    desc "create article"
    params do
      requires :title,   type: String
      requires :content, type: String
    end
    post do
      params do
        requires :title,   type: String
        requires :content, type: String
      end
      Article.create(
        title: params[:title],
        content: params[:content]
      )
    end

    desc "edit article"
    route_param :id do
      post do
        article = Article.where(id: params[:id]).first
        article.update_attributes(article_params)
        article
      end
    end

    desc "delete article"
    route_param :id do
      delete do
        article = Article.where(id: params[:id]).first
        article.destroy
      end
    end
  end

end
