app = angular.module('slpdevdoc', ['ngResource'])

app.factory 'Article', ($resource) =>
  Article = $resource('/api/article/:id', id: '@id')

app.controller 'articleCtrl', ($scope, Article) ->
  $scope.articles = Article.query()

  $scope.addArticle =  ->
    article = new Article(angular.copy $scope.article)
    article.$save()
    $scope.articles = Article.query()

  $scope.update = (article) ->
    console.log JSON.stringify(article)
    article.$save()
