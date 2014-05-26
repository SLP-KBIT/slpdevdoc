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
    console.log "edit called"
    console.log JSON.stringify this.article
    $scope.modalTitle = "記事の編集"
    $scope.modalButton = "Save"
    $scope.modalSubmit = "update()"
    $scope.article = this.article

  $scope.update = () ->
    article = scope.article
    console.log JSON.stringify(article)
    article.$save()

  $scope.show = ->
    $scope.showArticle = this.article
    $('#mdContent').html(marked(this.article.content))
