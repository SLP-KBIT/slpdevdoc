app = angular.module('slpdevdoc', [])

# app.factory('article', function)

app.controller 'articleCtrl', ($scope) ->
  $scope.articles = [
    {title: "sample title1", content: "sample content 1", editing: false}
    {title: "sample title2", content: "sample content 2", editing: false}
  ]

  $scope.addArticle =  ->
    article = angular.copy $scope.article
    article.editing = false
    $scope.articles.push(article)
    $scope.article = null

  $scope.update = (article) ->
    console.log "edit called. nothing to do unless using api."
    console.log JSON.stringify(article)
