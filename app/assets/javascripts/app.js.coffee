_.templateSettings =
  interpolate: /\{\{(.+?)\}\}/g
  evaluate: /\{%(.+?)%\}/g
  escape: /\{%-(.+?)%\}/g

# --------------------
# Model definitions
# --------------------
Article = Backbone.Model.extend
  urlRoot: "/api/article"

ArticleList = Backbone.Collection.extend
  # model: Article
  url: "/api/article"

# --------------------
# View
# --------------------
ArticleView = Backbone.View.extend
  el: '#articles'
  initialize: (model) ->
    this.add(model)
  add: (model) ->
    this.$el.append(_.template($("#article-template").html(), model))

# --------------------
# main
# --------------------
article = new Article()
@articleList = new ArticleList()
@articleList.fetch
  success: (model, response)->
    console.log "called"
    _.each response, (e) ->
      console.log JSON.stringify(e)
      new ArticleView(e)
