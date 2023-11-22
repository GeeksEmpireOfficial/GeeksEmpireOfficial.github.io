class ContentDataStructure {

  String packageName = "";

  String applicationName = "";
  String applicationSummary = "";
  String applicationDescription = "";

  String applicationIcon = "";
  /// CSV Of Screenshots Links
  String applicationScreenshots = "";

  String applicationYoutube = "https://www.youtube.com/@GeeksEmpireCo/community";
  String applicationX = "https://twitter.com/GeeksEmpire";
  String applicationFacebook = "https://facebook.com/GeeksEmpire";

  ContentDataStructure(String inputPackageName, String inputApplicationName, String inputApplicationSummary, String inputApplicationDescription,
      String inputApplicationIcon, String inputApplicationScreenshots,
      String inputApplicationYoutube, String inputApplicationX, String inputApplicationFacebook) {

    packageName = inputPackageName;

    applicationName = inputApplicationName;
    applicationSummary = inputApplicationSummary;
    applicationDescription = inputApplicationDescription;

    applicationIcon = inputApplicationIcon;
    applicationScreenshots = inputApplicationScreenshots;

    applicationYoutube = inputApplicationYoutube;
    applicationX = inputApplicationX;
    applicationFacebook = inputApplicationFacebook;

  }

  String packageNameValue() {

    return packageName.toString();
  }

  String applicationNameValue() {

    return applicationName.toString();
  }

  String applicationSummaryValue() {

    return applicationSummary.toString();
  }

  String applicationDescriptionValue() {

    return applicationDescription.toString();
  }

  String applicationIconValue() {

    return applicationIcon.toString();
  }

  List<String> applicationScreenshotsValue() {

    return applicationScreenshots.toString().split(",");
  }

  String applicationYoutubeValue() {

    return applicationYoutube.toString();
  }

  String applicationXValue() {

    return applicationX.toString();
  }

  String applicationFacebookValue() {

    return applicationFacebook.toString();
  }

}