app = angular.module('slpdevdoc', ['ngResource', 'ngRoute'])

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

app.controller 'articleCtrl', ($scope, Article) ->
  $scope.articles = Article.query()
  console.log JSON.stringify($scope.articles)

  $scope.save = ->
    $('#addArticleModal').modal('hide')
    article = $scope.article
    if $scope.modalButton == "Add"
      article = new Article(angular.copy $scope.article)
    article.$save()
    $scope.articles = Article.query()

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
    $scope.showArticle = this.article
    marked.setOptions
      gfm: true
      langPrefix: ''
      highlight: (code, lang)->
        return hljs.highlight(lang, code).value
    angular.element('#mdContent').html(marked(this.article.content))
    return
