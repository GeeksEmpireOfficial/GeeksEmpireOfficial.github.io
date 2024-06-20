class PostDataStructure {

  dynamic inputDynamicJson;

  PostDataStructure(dynamic dynamicJson) {

    inputDynamicJson = dynamicJson;

  }

  String postId() {

    return inputDynamicJson['id'].toString();
  }

  String postTitle() {

    return inputDynamicJson['title'];
  }

  String postLink() {

    return inputDynamicJson['url'];
  }

}