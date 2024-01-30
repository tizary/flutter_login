class Issues {
  String title;
  String metadataType;
  String metadataValue;

  Issues(
      {required this.title,
      required this.metadataType,
      required this.metadataValue});

  factory Issues.fromMap(issueMap) {
    return Issues(
      title: issueMap['title'] as String,
      metadataType: issueMap['metadata']['type'] as String,
      metadataValue: issueMap['metadata']['value'] as String,
    );
  }
}
