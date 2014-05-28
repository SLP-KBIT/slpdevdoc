app = angular.module('slpdevdoc', ['ngResource', 'ngRoute', 'ngTagsInput'])

# app.config ($routeProvider) ->
#   $routeProvider
#     .when '/',
#       templateURL: 'dummy.html'
#     .when '/#hoge',
#       templateUrl: 'top/index.html'
#     .when '/#',
#       templateUrl: 'top/index.html'

app.factory 'Article', ($resource) =>
  Article = $resource('/api/article/:id', id: '@id')

app.controller 'articleCtrl', ($scope, $http, Article) ->
  $scope.articles = Article.query()

  $scope.save = ->
    console.log "query first on save: " + JSON.stringify($scope.articles[0])
    $('#addArticleModal').modal('hide')
    article = $scope.article
    tags = article.tags
    if $scope.modalButton == "Add"
      article = new Article(angular.copy $scope.article)
    article.$save( (e) =>
      console.log "save response: " +
      $scope.article = e
      $scope.article.tags = tags
      $scope.updateTags()
      $scope.articles = Article.query()
    )

  $scope.updateTags = ->
    console.log "$scope.article.tags: in updateTags: " + JSON.stringify($scope.article)
    tags = $.map $scope.article.tags, (e) =>
      e.name
    param_tags = tags.join(",")
    $http.post '/api/article/' + $scope.article.id + '/tags', tags: param_tags

  $scope.new = ->
    $scope.modalTitle = "記事の作成"
    $scope.modalButton = "Add"
    $scope.modalSubmit = "save()"
    $scope.article = null

  $scope.addArticle =  ->
    article = new Article(angular.copy $scope.article)
    article.$save()
    $scope.articles = Article.query()

  $scope.edit = ->
    $scope.modalTitle = "記事の編集"
    $scope.modalButton = "Save"
    $scope.modalSubmit = "update()"
    $scope.article = $scope.showArticle

  $scope.update = () ->
    article = scope.article
    article.$save()

  $scope.delete = ->
    $scope.showArticle.$delete()
    $scope.showArticle = null
    angular.element('#mdContent').html('')
    $scope.articles = Article.query()

  $scope.show = ->
    console.log "query first on show: " + JSON.stringify($scope.articles[0])
    $scope.showArticle = this.article
    marked.setOptions
      gfm: true
      langPrefix: ''
      highlight: (code, lang)->
        return hljs.highlight(lang, code).value
    angular.element('#mdContent').html(marked(this.article.content))
    return

app.controller 'tagCtrl', ($scope, $http) ->
  $scope.loadTags = (query) =>
    console.log "called load tags"
    $http.get('/api/tag?query=' + query)
