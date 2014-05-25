app = angular.module('slpdevdoc', ['ngResource'])

app.factory 'Article', ($resource) =>
  Article = $resource('/api/article/:id', id: '@id')

app.controller 'articleCtrl', ($scope, Article) ->
  $scope.articles = Article.query()

  $scope.addArticle =  ->
    article = angular.copy $scope.article
    article.editing = false
    $scope.articles.push(article)
    $scope.article = null

  $scope.update = (article) ->
    console.log JSON.stringify(article)
    article.$save()
