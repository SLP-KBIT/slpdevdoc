@docCtrl = ($scope) ->  # or start with window.docCtl
  $scope.documents = [
    {title: "sample title1", content: "sample content 1"}
    {title: "sample title2", content: "sample content 2"}
  ]

  $scope.addDoc =  ->
    console.log "add called"

    $scope.documents.push
      title: $scope.doc.title
      content: $scope.doc.content

    $scope.docTitle = ""
    $scope.docContent = ""
