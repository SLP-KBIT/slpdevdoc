app = angular.module('slpdevdoc', [])

# app.factory('article', function)


@articleCtrl = ($scope) ->  # or start with window.articleCtl
  $scope.articles = [
    {title: "sample title1", content: "sample content 1",}
    {title: "sample title2", content: "sample content 2"}
  ]

  $scope.addArticle =  ->
    $scope.articles.push(angular.copy $scope.article)
    $scope.article = null

  $scope.edit = (article) ->
    console.log "edit called"
    console.log JSON.stringify(article)
